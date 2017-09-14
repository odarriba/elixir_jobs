defmodule ElixirJobsWeb.AuthController do
  use ElixirJobsWeb, :controller

  alias ElixirJobs.{
    Guardian,
    Users
  }

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
        |> redirect(to: offer_path(:index))
    else
      _ ->
        conn
        |> put_flash(:error, "Invalid credentials!")
    end
  end

  def delete(conn, params) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: offer_path(:index))
  end
end
