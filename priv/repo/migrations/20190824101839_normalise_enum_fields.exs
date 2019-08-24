defmodule ElixirJobs.Repo.Migrations.NormaliseEnumFields do
  use Ecto.Migration

  def change do
    alter table(:offers) do
      modify(:job_place, :string, null: false)
      modify(:job_type, :string, null: false)
    end

    Ecto.Migration.execute("DROP TYPE IF EXISTS job_place")
    Ecto.Migration.execute("DROP TYPE IF EXISTS job_type")
  end
end
