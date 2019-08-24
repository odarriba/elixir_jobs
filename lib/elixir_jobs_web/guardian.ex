defmodule ElixirJobsWeb.Guardian do
  @moduledoc """
  Main Guardian module definition, including how to store and recover users from
  and to the session.
  """

  use Guardian, otp_app: :elixir_jobs

  alias ElixirJobs.Accounts
  alias ElixirJobs.Accounts.Schemas.Admin

  def subject_for_token(%Admin{} = resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def subject_for_token(_, _) do
    {:error, :unknown_resource}
  end

  def resource_from_claims(claims) do
    admin = Accounts.get_admin_by_id!(claims["sub"])
    {:ok, admin}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
