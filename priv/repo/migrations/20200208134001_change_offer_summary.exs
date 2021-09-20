defmodule ElixirJobs.Repo.Migrations.ChangeOfferSummary do
  use Ecto.Migration

  def change do
    alter table("offers") do
      modify(:summary, :text, null: false)
    end
  end
end
