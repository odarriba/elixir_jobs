defmodule ElixirJobs.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_jobs,
      version: "0.0.1",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
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
      extra_applications: [
        :logger,
        :runtime_tools,
        :scrivener_ecto,
        :extwitter,
        :appsignal,
        :bamboo
      ]
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
      {:phoenix, "~> 1.4"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_html, "~> 2.13"},
      {:gettext, "~> 0.17.0"},
      {:cowboy, "~> 2.6"},
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.7"},
      # Database
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      # Auth
      {:guardian, "~> 2.0"},
      {:comeonin, "~> 5.1"},
      {:bcrypt_elixir, "~> 2.0"},
      # External services
      {:extwitter, "~> 0.8"},
      {:bamboo, "~> 1.3"},
      {:nadia, "~> 0.5"},
      # Monitoring
      {:appsignal, "~> 1.10"},
      # Misc
      {:slugger, "~> 0.3.0"},
      {:scrivener_ecto, "~> 2.2"},
      {:phoenix_html_sanitizer, "~> 1.1"},
      {:calendar, "~> 0.18.0"},
      {:jason, "~> 1.0"},
      # Tests and dev
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:faker, "~> 0.12", only: :test},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false}
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
