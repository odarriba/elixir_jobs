defmodule ElixirJobs.Users.Admin do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirJobs.Users.Admin


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "admins" do
    field :email, :string
    field :encrypted_password, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Admin{} = admin, attrs) do
    admin
    |> cast(attrs, [:name, :email, :encrypted_password])
    |> validate_required([:name, :email, :encrypted_password])
  end
end
