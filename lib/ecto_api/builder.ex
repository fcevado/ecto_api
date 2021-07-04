defmodule EctoApi.Builder do
  @callback cast(Ecto.Queryable.t(), any(), Keyword.t()) ::
              {:ok, Ecto.Schema.t()} | {:error, any()}
  @callback cast_many(Ecto.Queryable.t(), any(), Keyword.t()) ::
              {:ok, [Ecto.Schema.t()]} | {:error, any()}
end
