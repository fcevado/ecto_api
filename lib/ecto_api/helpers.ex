defmodule EctoApi.Helpers do
  def resolver(opts) do
    case opts[:resolver] do
      resolver when is_atom(resolver) -> {resolver, []}
      {resolver, resolver_opts} -> {resolver, resolver_opts}
    end
  end

  def client(opts) do
    case opts[:client] do
      client when is_atom(client) -> {client, []}
      {client, client_opts} -> {client, client_opts}
    end
  end

  def builder(opts) do
    case opts[:builder] do
      builder when is_atom(builder) -> {builder, []}
      {builder, builder_opts} -> {builder, builder_opts}
    end
  end

  def metadata(queryable) do
    source = queryable.__schema__(:source)
    prefix = queryable.__schema__(:prefix)

    %{source: source, prefix: prefix, queryable: queryable}
  end

  def queryable(%Ecto.Changeset{data: %{__struct__: queryable}}), do: queryable
  def queryable(%{__struct__: queryable}), do: queryable
end
