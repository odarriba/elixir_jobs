defmodule ElixirJobs.Repo do
  use Ecto.Repo, otp_app: :elixir_jobs
  use Scrivener, page_size: Application.get_env(:elixir_jobs, :items_per_page)

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
