defmodule ElixirJobs.Repo.Migrations.AddSummaryToOffers do
  use Ecto.Migration

  def change do
    alter table(:offers) do
      add :summary, :string, size: 200
    end

  end
end
