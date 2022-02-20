defmodule EctoApi do
  @moduledoc """
  """
  alias EctoApi.Metadata

  def insert(struct_or_changeset, opts \\ []) do
    with {:ok, meta} <- Metadata.build(struct_or_changeset, opts),
         builder <- meta[:builder],
         resolver <- meta[:resolver],
         client <- meta[:client],
         {:ok, params} <- builder[:module].dump(struct_or_changeset, builder[:opts]),
         {:ok, resolved} <- resolver[:module].dump(resolver[:meta], params, resolver[:opts]),
         {:ok, response} <- client[:module].post(resolved, client[:opts]),
         {:ok, schema} <- builder[:module].cast(meta[:module], response, builder[:opts]) do
      {:ok, Ecto.put_meta(schema, state: :loaded)}
    end
  end

  def update(struct_or_changeset, opts \\ []) do
    with {:ok, meta} <- Metadata.build(struct_or_changeset, opts),
         builder <- meta[:builder],
         resolver <- meta[:resolver],
         client <- meta[:client],
         {:ok, params} <- builder[:module].dump(struct_or_changeset, builder[:opts]),
         {:ok, resolved} <- resolver[:module].update(resolver[:meta], params, resolver[:opts]),
         {:ok, response} <- client[:module].put(resolved, client[:opts]),
         {:ok, schema} <- builder[:module].cast(meta[:module], response, builder[:opts]) do
      {:ok, Ecto.put_meta(schema, state: :loaded)}
    end
  end

  def delete(struct_or_changeset, opts \\ []) do
    with {:ok, meta} <- Metadata.build(struct_or_changeset, opts),
         builder <- meta[:builder],
         resolver <- meta[:resolver],
         client <- meta[:client],
         {:ok, params} <- builder[:module].dump(struct_or_changeset, builder[:opts]),
         {:ok, resolved} <- resolver[:module].delete(resolver[:meta], params, resolver[:opts]),
         {:ok, response} <- client[:module].delete(resolved, client[:opts]),
         {:ok, schema} <- builder[:module].cast(meta[:module], response, builder[:opts]) do
      {:ok, Ecto.put_meta(schema, state: :deleted)}
    end
  end

  def get(queryable, id, opts \\ []) do
    with {:ok, meta} <- Metadata.build(queryable, opts),
         builder <- meta[:builder],
         resolver <- meta[:resolver],
         client <- meta[:client],
         {:ok, resolved} <- resolver[:module].read(resolver[:meta], id, resolver[:opts]),
         {:ok, response} <- client[:module].get(resolved, client[:opts]),
         {:ok, schema} <- builder[:module].cast(meta[:module], response, builder[:opts]) do
      Ecto.put_meta(schema, state: :loaded)
    else
      _ -> nil
    end
  end

  def get_by(queryable, clauses, opts \\ []) do
    with {:ok, meta} <- Metadata.build(queryable, opts),
         builder <- meta[:builder],
         resolver <- meta[:resolver],
         client <- meta[:client],
         {:ok, resolved} <- resolver[:module].list(resolver[:meta], clauses, resolver[:opts]),
         {:ok, response} <- client[:module].get(resolved, client[:opts]),
         {:ok, schema} <- builder[:module].cast(meta[:module], response, builder[:opts]) do
      Ecto.put_meta(schema, state: :loaded)
    else
      _ -> nil
    end
  end

  def get_all(queryable, clauses, opts \\ []) do
    with {:ok, meta} <- Metadata.build(queryable, opts),
         builder <- meta[:builder],
         resolver <- meta[:resolver],
         client <- meta[:client],
         {:ok, resolved} <- resolver[:module].list(resolver[:meta], clauses, resolver[:opts]),
         {:ok, response} <- client[:module].get(resolved, client[:opts]),
         {:ok, schema} <- builder[:module].cast_many(meta[:module], response, builder[:opts]) do
      schema
    else
      _ -> nil
    end
  end
end
