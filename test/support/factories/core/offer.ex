defmodule ElixirJobs.Factories.Core.Offer do
  @moduledoc false

  use ElixirJobs.Factories.Base, :offer

  alias ElixirJobs.Core.Fields.JobPlace
  alias ElixirJobs.Core.Fields.JobType
  alias ElixirJobs.Core.Schemas.Offer

  def build_factory do
    %{
      title: Faker.Lorem.sentence(2),
      company: Faker.Lorem.sentence(2),
      location: Faker.StarWars.planet(),
      url: Faker.Internet.url(),
      contact_email: Faker.Internet.email(),
      summary: Faker.Lorem.sentence(8..10),
      job_place: Enum.random(JobPlace.available_values()),
      job_type: Enum.random(JobType.available_values())
    }
  end

  def get_schema, do: %Offer{}

  def get_changeset(attrs), do: Offer.changeset(%Offer{}, attrs)
end
