import Config

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
  issuer: "Elixir Jobs",
  secret_key: "MY_T3ST_K3Y"

config :elixir_jobs, ElixirJobsWeb.Mailer, adapter: Bamboo.TestAdapter

config :bamboo, :refute_timeout, 3

config :elixir_jobs, :default_app_email, "no-reply@elixirjobs.net"
config :elixir_jobs, :analytics_id, ""

# Import custom configuration
import_config "test.secret.exs"
