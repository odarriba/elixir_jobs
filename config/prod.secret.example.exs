use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :elixir_jobs, ElixirJobsWeb.Endpoint,
  secret_key_base: "SUPER_SECRET_KEY"

# Configure your database
config :elixir_jobs, ElixirJobs.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "DB_USER",
  password: "DB_PASSWORD",
  database: "DB_NAME",
  pool_size: 15
