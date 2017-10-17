defmodule ElixirJobsWeb.Twitter do
  alias ElixirJobs.Offers.Offer
  import ElixirJobsWeb.HumanizeHelper

  @short_link_length 25
  @twitter_limit 140
  @tags [
    "job",
    "myelixirstatus",
    "elixirlang"
  ]

  def publish(%Plug.Conn{} = conn, %Offer{} = offer) do
    text = get_text(offer)
    tags = get_tags()
    url = get_url(conn, offer)

    status_length = String.length(text) + String.length(tags) + 3 + @short_link_length

    case status_length do
      n when n <= @twitter_limit ->
        Enum.join([text, tags, url], " ")
      n ->
        exceed = n - @twitter_limit
        max_text_length = String.length(text) - exceed

        short_text =
          text
          |> String.slice(0, max_text_length - 3)
          |> Kernel.<>("...")

        Enum.join([short_text, tags, url], " ")
    end
    |> ExTwitter.update()
  end

  defp get_text(%Offer{company: company, title: title, job_place: job_place}) do
    "#{title} @ #{company} / #{human_get_place(job_place,"Unknown Place")}"
  end

  defp get_tags() do
    @tags
    |> Enum.map(&("##{&1}"))
    |> Enum.join(" ")
  end

  defp get_url(%Plug.Conn{} = conn, %Offer{slug: slug}) do
    ElixirJobsWeb.Router.Helpers.offer_url(conn, :show, slug)
  end
end
