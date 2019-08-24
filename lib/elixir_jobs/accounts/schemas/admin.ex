defmodule ElixirJobs.Accounts.Schemas.Admin do
  @moduledoc """
  Admin schema
  """

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "admins" do
    field :email, :string
    field :encrypted_password, :string
    field :name, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(admin, attrs) do
    admin
    |> cast(attrs, [:name, :email, :password, :password_confirmation])
    |> validate_required([:name, :email])
    |> validate_passwords()
    |> unique_constraint(:email)
    |> generate_passwords()
  end

  @doc """
  Function to check the `password` of a given `admin`.
  """
  def check_password(admin, password) do
    case Bcrypt.verify_pass(password, admin.encrypted_password) do
      true -> {:ok, admin}
      _ -> {:error, :wrong_credentials}
    end
  end

  @doc """
  Function to simulate checking a password to avoid time-based user discovery
  """
  def dummy_check_password do
    Bcrypt.no_user_verify()
    {:error, :wrong_credentials}
  end

  # Function to validate passwords only if they are changed or the admin is new.
  #
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

  # Function to generate password hash when creating/changing the password of an
  # admin account
  #
  defp generate_passwords(%Ecto.Changeset{errors: []} = changeset) do
    case get_field(changeset, :password) do
      password when not is_nil(password) ->
        hash = Bcrypt.hash_pwd_salt(password)
        put_change(changeset, :encrypted_password, hash)

      _ ->
        changeset
    end
  end

  defp generate_passwords(changeset), do: changeset
end
