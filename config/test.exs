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
  issuer: "ElixirJobs",
  secret_key: "MY_T3ST_K3Y"

config :elixir_jobs, ElixirJobsWeb.Mailer,
  adapter: Bamboo.TestAdapter

config :bamboo, :refute_timeout, 3

config :elixir_jobs, :home_url, "http://localhost:4000/"

#Import custom configuration
import_config "test.secret.exs"
