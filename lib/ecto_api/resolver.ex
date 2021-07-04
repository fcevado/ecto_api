defmodule EctoApi.Resolver do
  @callback read(map(), any(), Keyword.t()) :: {:ok, any()} | {:error, any()}
  @callback list(map(), Keyword.t(), Keyword.t()) :: {:ok, any()} | {:error, any()}
end
