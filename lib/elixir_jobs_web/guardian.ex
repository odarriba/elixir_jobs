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
  def resource_from_claims(_claims) do
    {:error, :resource_not_found}
  end

  defmodule AuthErrorHandler do
    import Plug.Conn
    import Phoenix.Controller

    def auth_error(conn, {type, reason}, _opts) do
      conn
      |> put_flash(:error, gettext("Authentication required"))
      |> redirect(to: auth_path(:new))
    end
  end
end
