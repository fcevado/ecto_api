defmodule EctoApi.Client do
  @callback get(any(), Keyword.t()) :: {:ok, any()} | {:error, any()}
end
