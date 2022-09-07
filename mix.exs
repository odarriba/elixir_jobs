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
      # Phoenix
      {:phoenix, "~> 1.6.0"},
      {:phoenix_pubsub, "~> 2.0"},
      {:plug_cowboy, "~> 2.1"},
      {:phoenix_html, "~> 3.0"},
      {:gettext, "~> 0.20.0"},
      # Database
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.7"},
      {:postgrex, ">= 0.0.0"},
      # Auth
      {:guardian, "~> 2.2"},
      {:comeonin, "~> 5.3"},
      {:bcrypt_elixir, "~> 3.0"},
      # External services
      {:extwitter, "~> 0.13.0"},
      {:oauther, "~> 1.1"},
      {:bamboo, "~> 2.0"},
      {:bamboo_phoenix, "~> 1.0"},
      {:nadia, "~> 0.7"},
      # Monitoring
      {:appsignal_phoenix, "~> 2.0"},
      # Misc
      {:slugger, "~> 0.3.0"},
      {:scrivener_ecto, "~> 2.7"},
      {:html_sanitize_ex, "~> 1.4"},
      {:calendar, "~> 1.0"},
      {:jason, "~> 1.2"},
      # Tests and dev
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:faker, "~> 0.16", only: :test},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
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
