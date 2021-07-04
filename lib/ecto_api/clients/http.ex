defmodule EctoApi.Clients.Http do
  @behaviour EctoApi.Client

  def post(request, opts) do
    request[:url]
    |> client(opts)
    |> Tesla.post(request[:path], request[:body],
      query: request[:query],
      headers: request[:headers]
    )
  end

  def put(request, opts) do
    request[:url]
    |> client(opts)
    |> Tesla.put(request[:path], request[:body],
      query: request[:query],
      headers: request[:headers]
    )
  end

  def delete(request, opts) do
    request[:url]
    |> client(opts)
    |> Tesla.delete(request[:path],
      query: request[:query],
      headers: request[:headers]
    )
  end

  def get(request, opts) do
    request[:url]
    |> client(opts)
    |> Tesla.get(request[:path], query: request[:query], headers: request[:headers])
  end

  defp client(url, opts) do
    middleware = build_middleware(url, opts[:json], opts[:auth])
    adapter = opts[:adapter] || Tesla.Adapter.Mint

    Tesla.client(middleware, adapter)
  end

  defp build_middleware(url, json, auth) do
    [{Tesla.Middleware.BaseUrl, url}, Tesla.Middleware.FollowRedirects]
    |> put_json(json)
    |> put_auth(auth)
    |> Enum.reverse()
  end

  defp put_json(middlewares, nil), do: [Tesla.Middleware.JSON | middlewares]
  defp put_json(middlewares, opts), do: [{Tesla.Middleware.JSON, opts} | middlewares]

  defp put_auth(middlewares, nil), do: middlewares
  defp put_auth(middlewares, opts), do: [{Tesla.Middleware.Headers, opts} | middlewares]
end
