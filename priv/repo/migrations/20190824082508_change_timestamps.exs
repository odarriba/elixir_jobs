defmodule ElixirJobs.Repo.Migrations.ChangeTimestamps do
  use Ecto.Migration

  def change do
    alter table(:offers) do
      modify(:published_at, :utc_datetime)
      modify(:inserted_at, :utc_datetime)
      modify(:updated_at, :utc_datetime)
    end

    alter table(:admins) do
      modify(:inserted_at, :utc_datetime)
      modify(:updated_at, :utc_datetime)
    end
  end
end
