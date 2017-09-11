defmodule ElixirJobs.Repo.Migrations.CreateOffers do
  use Ecto.Migration

  def change do
    create table(:offers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :description, :string, null: false
      add :location, :string, null: false
      add :url, :string, null: false

      timestamps()
    end

  end
end
