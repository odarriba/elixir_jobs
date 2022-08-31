# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

# General application configuration
config :elixir_jobs,
  ecto_repos: [ElixirJobs.Repo]

config :elixir_jobs,
  items_per_page: 10

# Configures the endpoint
config :elixir_jobs, ElixirJobsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IcrUuGYFkGys3tgfqEL5aGCHiAq4/bz4UcpvXFpLZde9Z3oWv//NdWfkXWA2BLNd",
  render_errors: [view: ElixirJobsWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: ElixirJobs.PubSub

# Appsignal
config :appsignal, :config,
  otp_app: :elixir_jobs,
  name: "ElixirJobs",
  env: Mix.env(),
  active: false

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
