defmodule EctoApi.Resolver do
  @moduledoc """
  """

  @doc """
  """
  @callback read(map(), any(), Keyword.t()) :: {:ok, any()} | {:error, any()}

  @doc """
  """
  @callback list(map(), Keyword.t(), Keyword.t()) :: {:ok, any()} | {:error, any()}

  @doc """
  """
  @callback create() :: {:ok, any()} | {:error, any()}

  @doc """
  """
  @callback update() :: {:ok, any()} | {:error, any()}

  @doc """
  """
  @callback delete() :: {:ok, any()} | {:error, any()}
end
