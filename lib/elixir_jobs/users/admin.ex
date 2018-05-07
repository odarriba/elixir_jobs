defmodule ElixirJobs.Users.Admin do
  @moduledoc """
  Admin schema
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias ElixirJobs.Users.Admin

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "admins" do
    field :email, :string
    field :encrypted_password, :string
    field :name, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%Admin{} = admin, attrs) do
    admin
    |> cast(attrs, [:name, :email, :password, :password_confirmation])
    |> validate_required([:name, :email])
    |> validate_passwords()
    |> unique_constraint(:email)
    |> generate_passwords()
  end

  def check_password(%Admin{} = admin, password) do
    case Comeonin.Bcrypt.checkpw(password, admin.encrypted_password) do
      true -> {:ok, admin}
      _ -> {:error, :wrong_credentials}
    end
  end

  def check_password(_, _) do
    Comeonin.Bcrypt.dummy_checkpw()
    {:error, :wrong_credentials}
  end

  defp validate_passwords(changeset) do
    case get_field(changeset, :encrypted_password) do
      nil ->
        changeset
        |> validate_required([:password, :password_confirmation])
        |> validate_confirmation(:password)

      _ ->
        changeset
        |> validate_confirmation(:password)
    end
  end

  defp generate_passwords(%Ecto.Changeset{errors: []} = changeset) do
    case get_field(changeset, :password) do
      password when not is_nil(password) ->
        hash = Comeonin.Bcrypt.hashpwsalt(password)
        put_change(changeset, :encrypted_password, hash)

      _ ->
        changeset
    end
  end

  defp generate_passwords(changeset), do: changeset
end
