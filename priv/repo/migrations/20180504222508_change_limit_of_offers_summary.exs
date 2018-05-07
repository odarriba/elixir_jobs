defmodule ElixirJobs.Repo.Migrations.ChangeLimitOfOffersSummary do
  use Ecto.Migration

  def change do
    alter table(:offers) do
      modify :description, :string, size: 1000, null: true
      modify :summary, :string, size: 450
    end
  end
end
