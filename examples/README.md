# Examples

Some examples to test and explore the proposed api for the library.

## reqres.in user

### insert

```elixir
%User{}
|> User.changeset(%{first_name: "John", last_name: "Doe"})
|> EctoApi.insert(resolver: EctoApi.Resolvers.Rest, client: EctoApi.Clients.Http, builder: User)
```

### update

```elixir
{:ok, user} =
  %User{}
  |> User.changeset(%{first_name: "John", last_name: "Doe"})
  |> EctoApi.insert(resolver: EctoApi.Resolvers.Rest, client: EctoApi.Clients.Http, builder: User)

user
|> User.changeset(%{first_name: "Janet", last_name: "Doe"})
|> EctoApi.update(resolver: EctoApi.Resolvers.Rest, client: EctoApi.Clients.Http, builder: User)
```

### delete

```elixir
{:ok, user} =
  %User{}
  |> User.changeset(%{first_name: "John", last_name: "Doe"})
  |> EctoApi.insert(resolver: EctoApi.Resolvers.Rest, client: EctoApi.Clients.Http, builder: User)

user
|> EctoApi.delete(resolver: EctoApi.Resolvers.Rest, client: EctoApi.Clients.Http, builder: User)
```

### get

```elixir
User
|> EctoApi.get(6, resolver: EctoApi.Resolvers.Rest, client: EctoApi.Clients.Http, builder: User)
```

### get_by

```elixir
User
|> EctoApi.get_by([{"page", "2"}], resolver: EctoApi.Resolvers.Rest, client: EctoApi.Clients.Http, builder: User)
```

### get_all

```elixir
User
|> EctoApi.get_by([{"page", "2"}], resolver: EctoApi.Resolvers.Rest, client: EctoApi.Clients.Http, builder: User)
```
