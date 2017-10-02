defmodule ElixirJobs.Repo.Migrations.AddSummaryToOffers do
  use Ecto.Migration

  def change do
    alter table(:offers) do
      add :summary, :string
    end

  end
end
