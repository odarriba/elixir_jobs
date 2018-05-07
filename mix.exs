defmodule ElixirJobs.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixir_jobs,
      version: "0.0.1",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
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
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:phoenix_html, "~> 2.10"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      # Database
      {:ecto, "~> 2.2.0"},
      {:postgrex, ">= 0.0.0"},
      # Auth
      {:guardian, "~> 1.0"},
      {:comeonin, "~> 4.0"},
      {:bcrypt_elixir, "~> 1.0"},
      # External services
      {:extwitter, "~> 0.8"},
      {:bamboo, "~> 0.8"},
      {:nadia, "~> 0.4"},
      # Monitoring
      {:appsignal, "~> 1.0"},
      # Misc
      {:slugger, "~> 0.2"},
      {:ecto_enum, "~> 1.0"},
      {:scrivener_ecto, "~> 1.0"},
      {:phoenix_html_sanitizer, "~> 1.1.0-rc1"},
      {:calendar, "~> 0.17"},
      # Tests and dev
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false}
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
