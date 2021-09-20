defmodule ElixirJobs.Factories.Accounts.Admin do
  @moduledoc false

  use ElixirJobs.Factories.Base, :admin

  alias ElixirJobs.Accounts.Schemas.Admin

  def build_factory do
    %{
      email: Faker.Internet.email(),
      name: Faker.Person.name(),
      password: "123456",
      password_confirmation: "123456"
    }
  end

  def get_schema, do: %Admin{}

  def get_changeset(attrs), do: Admin.changeset(%Admin{}, attrs)
end
