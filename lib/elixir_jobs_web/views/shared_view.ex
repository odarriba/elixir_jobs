defmodule ElixirJobsWeb.SharedView do
  use ElixirJobsWeb, :view

  def get_flash_messages(%Plug.Conn{} = conn) do
    conn
    |> Phoenix.Controller.get_flash()
    |> Map.values
  end
end
