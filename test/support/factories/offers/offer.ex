defmodule ElixirJobs.Factories.Offers.Offer do
  @moduledoc false

  use ElixirJobs.Factories.Base, :offer

  alias ElixirJobs.Offers.Fields.JobPlace
  alias ElixirJobs.Offers.Fields.JobType
  alias ElixirJobs.Offers.Schemas.Offer

  def build_factory do
    %{
      title: Faker.Lorem.sentence(),
      company: Faker.Company.name(),
      location: Faker.StarWars.planet(),
      url: Faker.Internet.url(),
      summary: Faker.Lorem.sentence(),
      job_place: Enum.random(JobPlace.available_values()),
      job_type: Enum.random(JobType.available_values())
    }
  end

  def get_schema, do: %Offer{}

  def get_changeset(attrs), do: Offer.changeset(%Offer{}, attrs)
end
