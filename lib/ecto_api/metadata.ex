defmodule EctoApi.Metadata do
  def build(params, opts) do
    with {:ok, struct} <- get_struct(params),
         {:ok, {resolver, resolver_opts}} <- get_component(struct, :resolver, opts),
         {:ok, {client, client_opts}} <- get_component(struct, :client, opts),
         {:ok, {builder, builder_opts}} <- get_component(struct, :builder, opts),
         {:ok, meta} <- get_meta(struct) do
      {:ok,
       %{
         resolver: %{module: resolver, opts: resolver_opts, meta: meta},
         client: %{module: client, opts: client_opts},
         builder: %{module: builder, opts: builder_opts}
       }}
    else
      _ -> {:error, :impossible_meta}
    end
  end

  defp get_struct(module) when is_atom(module) do
    with true <- Code.ensure_loaded?(module),
         functions <- module.__info__(:functions),
         arity when is_integer(arity) <- functions[:__struct__] do
      {:ok, module.__struct__()}
    else
      _ -> :error
    end
  end

  defp get_struct(%Ecto.Changeset{data: data}), do: get_struct(data)
  defp get_struct(%{__meta__: _} = struct), do: {:ok, struct}
  defp get_struct(_), do: :error

  defp get_component(%{__meta__: meta}, component, opts) do
    case normalize(opts[component] || Map.get(meta, :context)[component]) do
      nil -> :error
      config -> {:ok, config}
    end
  end

  defp get_component(_struct, _component, _opts), do: :error

  defp normalize({_module, _opts} = normalized), do: normalized
  defp normalize(module) when is_atom(module), do: {module, []}
  defp normalize(_), do: nil

  defp get_meta(%{__meta__: meta}) do
    {:ok,
     %{
       source: Map.get(meta, :source),
       prefix: Map.get(meta, :prefix),
       pagination: Map.get(meta, :context)[:pagination]
     }}
  end

  defp get_meta(_), do: :error
end
