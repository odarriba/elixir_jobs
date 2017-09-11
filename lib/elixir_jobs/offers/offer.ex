defmodule ElixirJobs.Offers.Offer do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirJobs.Offers.Offer


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "offers" do
    field :title, :string
    field :description, :string
    field :location, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(%Offer{} = offer, attrs) do
    offer
    |> cast(attrs, [:title, :url, :description])
    |> validate_required([:title, :location, :description, :url])
  end
end
