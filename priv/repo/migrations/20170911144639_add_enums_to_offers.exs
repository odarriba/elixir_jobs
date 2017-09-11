defmodule ElixirJobs.Repo.Migrations.AddEnumsToOffers do
  use Ecto.Migration

  alias ElixirJobs.EctoEnums.{
    JobTime,
    JobType
  }

  def up do
    JobTime.create_type
    JobType.create_type

    alter table(:offers) do
      add :job_time, :job_time, null: false
      add :job_type, :job_type, null: false
    end
  end

  def down do
    alter table(:offers) do
      remove :job_time
      remove :job_type
    end

    JobTime.drop_type
    JobType.drop_type
  end
end
