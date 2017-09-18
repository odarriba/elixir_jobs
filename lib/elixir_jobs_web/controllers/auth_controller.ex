defmodule ElixirJobsWeb.AuthController do
  use ElixirJobsWeb, :controller

  alias ElixirJobs.Users
  alias ElixirJobsWeb.Guardian

  plug :scrub_params, "auth" when action in [:create]

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"auth" => auth_params}) do
    with {:ok, email} <- Map.fetch(auth_params, "email"),
         {:ok, password} <- Map.fetch(auth_params, "password"),
         {:ok, admin} <- Users.auth_admin(email, password) do
      conn
      |> Guardian.Plug.sign_in(admin)
      |> put_flash(:info, gettext("Welcome %{user_name}!", user_name: admin.name))
      |> redirect(to: offer_path(conn, :index))
    else
      _ ->
        conn
        |> put_flash(:error, "Invalid credentials!")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: offer_path(conn, :index))
  end

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:error, gettext("Authentication required"))
    |> redirect(to: auth_path(conn, :new))
  end
end
