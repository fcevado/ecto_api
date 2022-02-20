defmodule Test do
  defmodule Weather do
    use Ecto.Schema

    @schema_context %{
      resolver: EctoApi.Resolvers.Rest,
      client: EctoApi.Clients.Http,
      builder: __MODULE__
    }
    @schema_prefix "https://www.metaweather.com/api"
    @primary_key {:woeid, :id, autogenerate: false}
    schema "/location" do
      field(:consolidated_weather, {:array, :map})
      field(:sources, {:array, :map})

      field(:parent, :map)

      field(:sun_set, :utc_datetime)
      field(:sun_rise, :utc_datetime)
      field(:time, :utc_datetime)

      field(:title, :string)
      field(:timezone, :string)
      field(:timezone_name, :string)
      field(:location_type, :string)
      field(:latt_long, :string)
    end
  end

  defmodule User do
    use Ecto.Schema

    @schema_context %{
      resolver: EctoApi.Resolvers.Rest,
      client: EctoApi.Clients.Http,
      builder: __MODULE__
    }
    @schema_prefix "http://reqres.in/api"
    schema "/users" do
      field(:email, :string)
      field(:first_name, :string)
      field(:last_name, :string)
      field(:avatar, :string)
    end

    def changeset(struct, params) do
      fields = ~w(id email first_name last_name avatar)a

      Ecto.Changeset.cast(struct, params, fields)
    end

    def cast(_queryable, response, _opts) do
      with status when status in [200, 201, 204] <- response.status,
           params <- extract(response.body),
           struct <- cast(params) do
        {:ok, struct}
      else
        _ -> {:error, :casting}
      end
    end

    def cast_many(_queryable, response, _opts) do
      users =
        response.body["data"]
        |> Enum.map(&cast/1)

      {:ok, users}
    end

    def dump(%Ecto.Changeset{} = changeset, _opts) do
      params = changeset.changes
      id = changeset.data.id
      {:ok, %{params: params, id: id}}
    end

    def dump(%__MODULE__{} = struct, _opts) do
      params =
        struct
        |> Map.take(__MODULE__.__schema__(:fields))

      {:ok, %{params: params, id: struct.id}}
    end

    def dump(_struct, _opts), do: {:error, :dump}

    defp extract(%{"data" => nil}), do: nil
    defp extract(%{"data" => [user | _]}), do: user
    defp extract(%{"data" => user}), do: user
    defp extract(user) when is_map(user), do: user
    defp extract(_), do: nil

    defp cast(nil), do: cast(%{})

    defp cast(params) do
      %__MODULE__{}
      |> changeset(params)
      |> Ecto.Changeset.apply_changes()
    end
  end
end
