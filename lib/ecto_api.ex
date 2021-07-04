defmodule EctoApi do
  @moduledoc """
  """
  alias EctoApi.Helpers

  def insert(struct_or_changeset, opts) do
    {resolver, resolver_opts} = Helpers.resolver(opts)
    {client, client_opts} = Helpers.client(opts)
    {builder, builder_opts} = Helpers.builder(opts)
    queryable = Helpers.queryable(struct_or_changeset)
    metadata = Helpers.metadata(queryable)

    with {:ok, params} <- builder.dump(struct_or_changeset),
         {:ok, resolved} <- resolver.create(metadata, params, resolver_opts),
         {:ok, response} <- client.post(resolved, client_opts),
         {:ok, schema} <- builder.cast(queryable, response, builder_opts) do
      {:ok, schema}
    end
  end

  def update(struct_or_changeset, opts) do
    {resolver, resolver_opts} = Helpers.resolver(opts)
    {client, client_opts} = Helpers.client(opts)
    {builder, builder_opts} = Helpers.builder(opts)
    queryable = Helpers.queryable(struct_or_changeset)
    metadata = Helpers.metadata(queryable)

    with {:ok, params} <- builder.dump(struct_or_changeset),
         {:ok, resolved} <- resolver.update(metadata, params, resolver_opts),
         {:ok, response} <- client.put(resolved, client_opts),
         {:ok, schema} <- builder.cast(queryable, response, builder_opts) do
      {:ok, schema}
    end
  end

  def delete(struct_or_changeset, opts) do
    {resolver, resolver_opts} = Helpers.resolver(opts)
    {client, client_opts} = Helpers.client(opts)
    {builder, builder_opts} = Helpers.builder(opts)
    queryable = Helpers.queryable(struct_or_changeset)
    metadata = Helpers.metadata(queryable)

    with {:ok, params} <- builder.dump(struct_or_changeset),
         {:ok, resolved} <- resolver.delete(metadata, params, resolver_opts),
         {:ok, response} <- client.delete(resolved, client_opts),
         {:ok, schema} <- builder.cast(queryable, response, builder_opts) do
      {:ok, schema}
    end
  end

  def get(queryable, id, opts) do
    {resolver, resolver_opts} = Helpers.resolver(opts)
    {client, client_opts} = Helpers.client(opts)
    {builder, builder_opts} = Helpers.builder(opts)
    metadata = Helpers.metadata(queryable)

    with {:ok, resolved} <- resolver.read(metadata, id, resolver_opts),
         {:ok, response} <- client.get(resolved, client_opts),
         {:ok, schema} <- builder.cast(queryable, response, builder_opts) do
      schema
    else
      _ -> nil
    end
  end

  def get_by(queryable, clauses, opts) do
    {resolver, resolver_opts} = Helpers.resolver(opts)
    {client, client_opts} = Helpers.client(opts)
    {builder, builder_opts} = Helpers.builder(opts)
    metadata = Helpers.metadata(queryable)

    with {:ok, resolved} <- resolver.list(metadata, clauses, resolver_opts),
         {:ok, response} <- client.get(resolved, client_opts),
         {:ok, schema} <- builder.cast(queryable, response, builder_opts) do
      schema
    else
      _ -> nil
    end
  end

  def get_all(queryable, clauses, opts) do
    {resolver, resolver_opts} = Helpers.resolver(opts)
    {client, client_opts} = Helpers.client(opts)
    {builder, builder_opts} = Helpers.builder(opts)
    metadata = Helpers.metadata(queryable)

    with {:ok, resolved} <- resolver.list(metadata, clauses, resolver_opts),
         {:ok, response} <- client.get(resolved, client_opts),
         {:ok, schema} <- builder.cast_many(queryable, response, builder_opts) do
      schema
    else
      _ -> nil
    end
  end
end
