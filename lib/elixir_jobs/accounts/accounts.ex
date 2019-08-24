defmodule ElixirJobs.Accounts do
  @moduledoc """
  The Accounts context
  """

  alias ElixirJobs.Accounts.Managers
  alias ElixirJobs.Accounts.Services

  defdelegate list_admins(), to: Managers.Admin
  defdelegate get_admin_by_id!(id), to: Managers.Admin
  defdelegate get_admin_by_email!(email), to: Managers.Admin
  defdelegate create_admin(attrs \\ %{}), to: Managers.Admin
  defdelegate update_admin(admin, attrs), to: Managers.Admin
  defdelegate delete_admin(admin), to: Managers.Admin
  defdelegate change_admin(admin), to: Managers.Admin
  defdelegate admin_emails(), to: Managers.Admin

  defdelegate authenticate_admin(email, password), to: Services.AuthenticateAdmin, as: :call
end
