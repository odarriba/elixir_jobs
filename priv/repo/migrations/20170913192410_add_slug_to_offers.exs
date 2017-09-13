defmodule ElixirJobs.Repo.Migrations.AddSlugToOffers do
  use Ecto.Migration

  def change do
    alter table(:offers) do
      add :slug, :string, null: false
    end

    create index(:offers, [:slug], unique: true)
  end
end
