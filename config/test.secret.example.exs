use Mix.Config

# Configure your database
config :elixir_jobs, ElixirJobs.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "DB_USER",
  password: "DB_PASSWORD",
  database: "elixir_jobs_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
