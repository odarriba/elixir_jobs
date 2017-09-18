defmodule ElixirJobsWeb.Plugs.CurrentUser do
  import Plug.Conn

  alias ElixirJobs.Users.Admin

  def init(_), do: []

  def call(conn, _) do
    case ElixirJobsWeb.Guardian.Plug.current_resource(conn) do
      %Admin{} = user -> assign(conn, :current_user, user)
      _ -> conn
    end
  end

  def current_user(conn) do
    Map.get(conn.assigns, :current_user)
  end

  def user_logged_in?(conn), do: !is_nil(Map.get(conn.assigns, :current_user))
end
