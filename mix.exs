defmodule EctoApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_api,
      name: "EctoApi",
      source_url: url(),
      description: description(),
      package: package(),
      version: "0.0.1",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, github: "elixir-ecto/ecto", commit: "a931b4f"},
      {:tesla, "~> 1.4", optional: true},
      {:mint, "~> 1.3", optional: true},
      {:jason, "~> 1.2", optional: true},
      {:castore, "~> 0.1.10", optional: true},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end

  defp description, do: "NOT STABLE YET. A library to describe resources from external apis."

  defp package do
    [
      files: ~w(lib .formatter.exs mix.exs mix.lock README.md LICENSE CHANGELOG.md),
      licenses: ["Apache-2.0"],
      links: %{"Github" => url()}
    ]
  end

  defp url, do: "https://github.com/fcevado/ecto_api"
end
