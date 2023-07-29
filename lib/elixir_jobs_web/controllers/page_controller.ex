defmodule ElixirJobsWeb.PageController do
  use ElixirJobsWeb, :controller

  def about(conn, _params) do
    render(conn, "about.html")
  end

  def sponsors(conn, _params) do
    render(conn, "sponsors.html")
  end
end
