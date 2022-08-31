import Config

# Configure your database
config :elixir_jobs, ElixirJobs.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.fetch_env!("POSTGRES_USERNAME"),
  password: System.fetch_env!("POSTGRES_PASSWORD"),
  database: System.fetch_env!("POSTGRES_DB"),
  hostname: System.fetch_env!("POSTGRES_HOST"),
  pool: Ecto.Adapters.SQL.Sandbox
