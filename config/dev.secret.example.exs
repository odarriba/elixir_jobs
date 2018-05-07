use Mix.Config

# Configure your database
config :elixir_jobs, ElixirJobs.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "DB_USERNAME",
  password: "DB_PASSWORD",
  database: "elixir_jobs_dev",
  hostname: "localhost",
  pool_size: 10

config :extwitter, :oauth,
  consumer_key: "",
  consumer_secret: "",
  access_token: "",
  access_token_secret: ""

config :nadia, token: ""
