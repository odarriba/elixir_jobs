defmodule ElixirJobs.Accounts.Services.AuthenticateAdmin do
  @moduledoc """
  Service to make administration authentication
  """

  alias ElixirJobs.Accounts.Managers.Admin, as: AdminManager
  alias ElixirJobs.Accounts.Schemas.Admin

  @doc """
  Receives email and password and tries to fetch the user from the database and
  authenticate it
  """
  def call(email, password) do
    admin = AdminManager.get_admin_by_email!(email)

    case Admin.check_password(admin, password) do
      {:ok, admin} -> {:ok, admin}
      {:error, error} -> {:error, error}
    end
  rescue
    Ecto.NoResultsError -> Admin.dummy_check_password()
  end
end
