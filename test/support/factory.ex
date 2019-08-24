defmodule ElixirJobs.Factory do
  @moduledoc """
  Main factory file, which contains all the building functions imported from
  the different factories in build time.
  """

  alias ElixirJobs.Repo

  # Factories included
  use ElixirJobs.Factories.Accounts.Admin
  use ElixirJobs.Factories.Core.Offer

  def params_for(schema, attrs \\ []) do
    extra_attrs = Enum.into(attrs, %{})

    schema
    |> build_factory()
    |> Map.merge(extra_attrs)
  end

  def build(schema, attrs \\ []) do
    schema
    |> params_for(attrs)
    |> get_changeset(schema)
    |> Ecto.Changeset.apply_changes()
  end

  def insert(schema, attrs \\ []) do
    schema
    |> params_for(attrs)
    |> get_changeset(schema)
    |> Repo.insert!()
  end
end
