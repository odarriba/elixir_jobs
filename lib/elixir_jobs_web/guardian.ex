defmodule ElixirJobsWeb.Guardian do
  use Guardian, otp_app: :elixir_jobs

  alias ElixirJobs.{
    Users,
    Users.Admin
  }

  def subject_for_token(%Admin{} = resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def subject_for_token(_, _) do
    {:error, :unknown_resource}
  end

  def resource_from_claims(claims) do
    case Users.get_admin_by_id(claims["sub"]) do
      %Admin{} = admin -> {:ok, admin}
      _ -> {:error, :resource_not_found}
    end
  end
end
