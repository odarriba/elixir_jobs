defmodule ElixirJobsWeb.LayoutView do
  use ElixirJobsWeb, :view

  import Phoenix.Controller, only: [current_url: 1]

  alias ElixirJobsWeb.MicrodataHelper
  alias ElixirJobsWeb.SeoHelper
  alias ElixirJobsWeb.Telegram

  def get_flash_messages(%Plug.Conn{} = conn) do
    conn
    |> Phoenix.Controller.get_flash()
    |> Map.values()
  end

  def get_telegram_channel, do: Telegram.get_channel()
end
