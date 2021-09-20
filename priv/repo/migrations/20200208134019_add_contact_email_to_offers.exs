defmodule ElixirJobs.Repo.Migrations.AddContactEmailToOffers do
  use Ecto.Migration

  def up do
    alter table("offers") do
      add(:contact_email, :string)
    end

    flush()

    ElixirJobs.Repo.update_all(ElixirJobs.Core.Schemas.Offer, set: [contact_email: "Unknown"])

    alter table("offers") do
      modify(:contact_email, :string, null: false)
    end
  end

  def down do
    alter table("offers") do
      remove(:contact_email)
    end
  end
end
