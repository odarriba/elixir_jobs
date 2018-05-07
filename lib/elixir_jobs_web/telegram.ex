defmodule ElixirJobsWeb.Telegram do
  @moduledoc """
  Module to send new elixir job offers to telegram channel.
  """

  alias ElixirJobs.Offers.Offer
  alias ElixirJobsWeb.Router.Helpers, as: Routehelpers
  alias ElixirJobsWeb.HumanizeHelper
  alias ElixirJobsWeb.Gettext

  require ElixirJobsWeb.Gettext

  def send(%Plug.Conn{} = conn, %Offer{} = offer) do
    channel = get_channel()
    send(conn, offer, channel)
  end

  def send(_, _, ""), do: :ok

  def send(%Plug.Conn{} = conn, %Offer{} = offer, channel) do
    job_type = HumanizeHelper.human_get_type(offer.job_type, Gettext.gettext("Unknown"))
    job_place = HumanizeHelper.human_get_place(offer.job_place, Gettext.gettext("Unknown"))

    text = """
    *#{offer.title}*
    #{offer.company} (#{offer.location})
    #{job_type} - #{job_place}
    #{Routehelpers.offer_url(conn, :show, offer.slug)}
    """

    case Nadia.send_message("@#{channel}", text, parse_mode: "Markdown") do
      {:ok, _result} ->
        :ok

      error ->
        error
    end
  end

  def get_channel() do
    Application.get_env(:elixir_jobs, :telegram_channel, "")
  end
end
