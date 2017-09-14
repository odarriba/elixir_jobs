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

config :elixir_jobs, ElixirJobsWeb.Guardian,
  issuer: "ElixirJobs"
  secret_key: "MY_T3ST_K3Y"

#Import custom configuration
import_config "test.secret.exs"
