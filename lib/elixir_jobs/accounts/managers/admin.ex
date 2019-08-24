defmodule ElixirJobs.Accounts.Managers.Admin do
  @moduledoc """
  The Admin manager.
  """

  alias ElixirJobs.Accounts.Queries.Admin, as: AdminQuery
  alias ElixirJobs.Accounts.Schemas.Admin
  alias ElixirJobs.Repo

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

  @doc """
  Returns an array of tuples with {%Admin{name}, %Admin{email}} to be used on email sending

  ## Examples

    iex> admin_emails
    {"admin_name", "admin_email"}
  """

  def admin_emails do
    Admin
    |> AdminQuery.only_admin_emails()
    |> Repo.all()
  end
end
