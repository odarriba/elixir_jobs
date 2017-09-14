defmodule ElixirJobs.Users do
  @moduledoc """
  The Users context.
  """

  alias ElixirJobs.Repo

  alias ElixirJobs.Users.Queries.Admin, as: AdminQuery

  alias ElixirJobs.Users.Admin

  @doc """
  Returns the list of admins.

  ## Examples

      iex> list_admins()
      [%Admin{}, ...]

  """
  def list_admins do
    Repo.all(Admin)
  end

  @doc """
  Gets a single admin by id.

  Raises `Ecto.NoResultsError` if the Admin does not exist.

  ## Examples

      iex> get_admin_by_id!(123)
      %Admin{}

      iex> get_admin_by_id!(456)
      ** (Ecto.NoResultsError)

  """
  def get_admin_by_id!(id) do
    Admin
    |> AdminQuery.by_id(id)
    |> Repo.one!()
  end

  @doc """
  Gets a single admin by id.

  Returns `nil` if the Admin does not exist.

  ## Examples

      iex> get_admin_by_id(123)
      %Admin{}

      iex> get_admin_by_id(456)
      nil

  """
  def get_admin_by_id(id) do
    Admin
    |> AdminQuery.by_id(id)
    |> Repo.one()
  end

  @doc """
  Gets a single admin by email.

  Raises `Ecto.NoResultsError` if the Admin does not exist.

  ## Examples

      iex> get_admin_by_email!(admin@elixirjobs.net)
      %Admin{}

      iex> get_admin_by_email!(wadus@gmail.com)
      ** (Ecto.NoResultsError)

  """
  def get_admin_by_email!(email) do
    Admin
    |> AdminQuery.by_email(email)
    |> Repo.one!()
  end

  @doc """
  Gets a single admin by email.

  Raises `Ecto.NoResultsError` if the Admin does not exist.

  ## Examples

      iex> auth_admin!("admin@elixirjobs.net", "123456")
      {:ok, %Admin{}}

      iex> auth_admin!("admin@elixirjobs.net", "wrong_password")
      {:error, :wrong_credentials}

      iex> auth_admin!("non-admin@elixirjobs.net", "password")
      {:error, :wrong_credentials}

  """
  def auth_admin(email, password) do
    admin =
      Admin
      |> AdminQuery.by_email(email)
      |> Repo.one()

    case Admin.check_password(admin, password) do
      {:ok, admin} -> {:ok, admin}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Creates a admin.

  ## Examples

      iex> create_admin(%{field: value})
      {:ok, %Admin{}}

      iex> create_admin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_admin(attrs \\ %{}) do
    %Admin{}
    |> Admin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a admin.

  ## Examples

      iex> update_admin(admin, %{field: new_value})
      {:ok, %Admin{}}

      iex> update_admin(admin, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_admin(%Admin{} = admin, attrs) do
    admin
    |> Admin.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Admin.

  ## Examples

      iex> delete_admin(admin)
      {:ok, %Admin{}}

      iex> delete_admin(admin)
      {:error, %Ecto.Changeset{}}

  """
  def delete_admin(%Admin{} = admin) do
    Repo.delete(admin)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking admin changes.

  ## Examples

      iex> change_admin(admin)
      %Ecto.Changeset{source: %Admin{}}

  """
  def change_admin(%Admin{} = admin) do
    Admin.changeset(admin, %{})
  end
end
