defmodule EctoApi.Builders.Basic do
  @behaviour EctoApi.Builder

  def cast(queryable, response, opts) do
    struct = queryable.__struct__()
    fields = queryable.__schema__(:fields)

    struct =
      struct
      |> Ecto.Changeset.cast(response.body, fields, opts)
      |> Ecto.Changeset.apply_changes()

    {:ok, struct}
  end

  def cast_many(queryable, response, opts) do
    structs =
      response
      |> Enum.map(&cast(queryable, &1, opts))
      |> Enum.map(&unwrap/1)

    {:ok, structs}
  end

  defp unwrap({:ok, struct}), do: struct
end
