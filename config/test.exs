use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_jobs, ElixirJobsWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# BCrypt configuration
config :bcrypt_elixir, :log_rounds, 4

#Import custom configuration
import_config "test.secret.exs"
