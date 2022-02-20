defmodule EctoApi.Builder do
  @moduledoc """
  """
  @doc """
  """
  @callback cast(Ecto.Queryable.t(), any(), Keyword.t()) ::
              {:ok, Ecto.Schema.t()} | {:error, any()}

  @doc """
  """
  @callback cast_many(Ecto.Queryable.t(), any(), Keyword.t()) ::
              {:ok, [Ecto.Schema.t()]} | {:error, any()}

  @doc """
  """
  @callback dump() :: {:ok, any()} | {:error, any()}
end
