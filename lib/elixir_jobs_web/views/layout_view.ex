defmodule ElixirJobsWeb.LayoutView do
  use ElixirJobsWeb, :view

  import Phoenix.Controller, only: [current_url: 1, controller_module: 1, action_name: 1]

  alias ElixirJobsWeb.MicrodataHelper
  alias ElixirJobsWeb.OfferController
  alias ElixirJobsWeb.PageController
  alias ElixirJobsWeb.SeoHelper
  alias ElixirJobsWeb.Telegram

  def get_flash_messages(%Plug.Conn{} = conn) do
    conn
    |> Phoenix.Controller.get_flash()
    |> Map.values()
  end

  def show_new_offer_button(conn) do
    current_controller = controller_module(conn)
    current_action = action_name(conn)

    case {current_controller, current_action} do
      {OfferController, :index} -> true
      {OfferController, :index_filtered} -> true
      {OfferController, :search} -> true
      {PageController, :about} -> true
      _ -> false
    end
  end

  def get_telegram_channel, do: Telegram.get_channel()
end
