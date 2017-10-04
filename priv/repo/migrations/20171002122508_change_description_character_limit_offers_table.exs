defmodule ElixirJobs.Repo.Migrations.ChangeDescriptionCharacterLimitOffersTable do
  use Ecto.Migration

  def change do
    alter table(:offers) do
      modify :description, :string, size: 1000
    end

  end
end
