defmodule ElixirJobs.Repo.Migrations.AddEnumsToOffers do
  use Ecto.Migration

  def up do
    alter table(:offers) do
      add(:job_place, :string, null: false)
      add(:job_type, :string, null: false)
    end
  end

  def down do
    alter table(:offers) do
      remove(:job_place)
      remove(:job_type)
    end
  end
end
