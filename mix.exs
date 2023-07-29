defmodule ElixirJobs.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_jobs,
      version: "0.0.1",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ElixirJobs.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:appsignal_phoenix, "~> 2.0"},
      {:bamboo_phoenix, "~> 1.0"},
      {:bamboo, "~> 2.0"},
      {:bcrypt_elixir, "~> 3.0"},
      {:calendar, "~> 1.0"},
      {:comeonin, "~> 5.3"},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.7"},
      {:extwitter, "~> 0.13.0"},
      {:faker, "~> 0.16", only: :test},
      {:gettext, "~> 0.20.0"},
      {:guardian, "~> 2.2"},
      {:html_sanitize_ex, "~> 1.4"},
      {:jason, "~> 1.2"},
      {:nadia, "~> 0.7"},
      {:oauther, "~> 1.1"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix, "~> 1.6.0"},
      {:plug_cowboy, "~> 2.1"},
      {:postgrex, ">= 0.0.0"},
      {:scrivener_ecto, "~> 2.7"},
      {:slugger, "~> 0.3.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.drop --quiet", "ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
