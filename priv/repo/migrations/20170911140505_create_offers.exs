defmodule ElixirJobs.Repo.Migrations.CreateOffers do
  use Ecto.Migration

  def change do
    create table(:offers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false, size: 80
      add :company, :string, null: false, size: 80
      add :description, :string, null: false, size: 500
      add :location, :string, null: false, size: 50
      add :url, :string, null: false, size: 255

      timestamps()
    end

  end
end
