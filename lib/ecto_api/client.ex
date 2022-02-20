defmodule EctoApi.Client do
  @moduledoc """
  """
  @doc """
  """
  @callback get(any(), Keyword.t()) :: {:ok, any()} | {:error, any()}

  @doc """
  """
  @callback post(any(), Keyword.t()) :: {:ok, any()} | {:error, any()}

  @doc """
  """
  @callback put(any(), Keyword.t()) :: {:ok, any()} | {:error, any()}

  @doc """
  """
  @callback delete(any(), Keyword.t()) :: {:ok, any()} | {:error, any()}
end
