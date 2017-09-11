defmodule ElixirJobs.Repo.Migrations.AddEnumsToOffers do
  use Ecto.Migration

  alias ElixirJobs.EctoEnums.{
    JobPlace,
    JobType
  }

  def up do
    JobPlace.create_type
    JobType.create_type

    alter table(:offers) do
      add :job_place, :job_place, null: false
      add :job_type, :job_type, null: false
    end
  end

  def down do
    alter table(:offers) do
      remove :job_place
      remove :job_type
    end

    JobPlace.drop_type
    JobType.drop_type
  end
end
