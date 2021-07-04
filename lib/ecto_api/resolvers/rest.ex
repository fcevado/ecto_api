defmodule EctoApi.Resolvers.Rest do
  @behaviour EctoApi.Resolver

  def create(metadata, %{params: params}, opts) do
    url = build_url(metadata, opts)
    headers = build_headers(opts)

    {:ok, %{url: url, path: "", body: params, query: [], headers: headers}}
  end

  def update(metadata, %{params: params, id: id}, opts) do
    url = build_url(metadata, opts)
    path = build_path(id, opts)
    headers = build_headers(opts)

    {:ok, %{url: url, path: path, body: params, query: [], headers: headers}}
  end

  def delete(metadata, %{id: id}, opts) do
    url = build_url(metadata, opts)
    path = build_path(id, opts)
    headers = build_headers(opts)

    {:ok, %{url: url, path: path, query: [], headers: headers}}
  end

  def read(metadata, id, opts) do
    url = build_url(metadata, opts)
    path = build_path(id, opts)
    headers = build_headers(opts)

    {:ok, %{url: url, path: path, query: [], headers: headers}}
  end

  def list(metadata, clauses, opts) do
    url = build_url(metadata, opts)
    query = build_query(clauses, opts)
    headers = build_headers(opts)

    {:ok, %{url: url, path: "", query: query, headers: headers}}
  end

  defp build_url(metadata, opts) do
    (opts[:base_url] || "") <> metadata[:prefix] <> metadata[:source]
  end

  defp build_path(id, _opts) do
    "/" <> to_string(id)
  end

  defp build_headers(opts) do
    opts[:headers]
    |> List.wrap()
    |> Enum.filter(&possible_header/1)
  end

  defp possible_header({k, v}) when is_binary(k) and is_binary(v), do: true
  defp possible_header(_), do: false

  defp build_query(clauses, _opts) do
    clauses
    |> List.wrap()
    |> Enum.filter(&possible_query/1)
  end

  defp possible_query({k, v}) when is_binary(k) and is_binary(v), do: true
  defp possible_query({k, v}) when is_atom(k) and is_binary(v), do: true
  defp possible_query(_), do: false
end
