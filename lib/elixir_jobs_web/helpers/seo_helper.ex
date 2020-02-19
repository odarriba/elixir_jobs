defmodule ElixirJobsWeb.SeoHelper do
  @moduledoc """
  Module with SEO-related functions like the ones to generate descriptions,
  titles, etc.
  """

  use ElixirJobsWeb, :view

  import Phoenix.Controller, only: [view_module: 1, view_template: 1]

  @default_page_title "Find your next job the right way"
  @default_page_description "Elixir Jobs helps developers to find their next Elixir job and companies to spread their offers. Use our search engine to find your next dream job."

  alias ElixirJobs.Core.Schemas.Offer
  alias ElixirJobsWeb.ErrorView
  alias ElixirJobsWeb.OfferView
  alias ElixirJobsWeb.PageView

  def page_title(%Plug.Conn{} = conn) do
    get_page_title(view_module(conn), view_template(conn), conn.assigns, conn.params)
  end

  def page_title(_), do: gettext(@default_page_title)

  def page_description(%Plug.Conn{} = conn) do
    get_page_description(view_module(conn), view_template(conn), conn.assigns)
  end

  def page_description(_), do: gettext(@default_page_description)

  defp get_page_title(OfferView, "new.html", _, _), do: gettext("Publish a job offer")

  defp get_page_title(OfferView, action, _, params)
       when action in [:index_filtered, :search] do
    job_type =
      params
      |> Map.get("filters", %{})
      |> Map.get("job_type", "")

    job_place =
      params
      |> Map.get("filters", %{})
      |> Map.get("job_place", "")

    case {job_type, job_place} do
      {"full_time", ""} -> gettext("Full time Elixir job offers")
      {"part_time", ""} -> gettext("Part time Elixir job offers")
      {"freelance", ""} -> gettext("Freelance Elixir job offers")
      {"", "onsite"} -> gettext("On site Elixir job offers")
      {"", "remote"} -> gettext("Remote Elixir job offers")
      _ -> gettext(@default_page_title)
    end
  end

  defp get_page_title(OfferView, "show.html", %{:offer => %Offer{} = offer}, _),
    do: "#{offer.title} @ #{offer.company}"

  defp get_page_title(ErrorView, "404.html", _, _),
    do: gettext("Not Found")

  defp get_page_title(ErrorView, "500.html", _, _),
    do: gettext("Internal Error")

  defp get_page_title(PageView, "about.html", _, _), do: gettext("About")

  defp get_page_title(AuthView, action, _, _) when action in [:new, :create],
    do: gettext("Log in")

  defp get_page_title(_, _, _, _), do: gettext(@default_page_title)

  defp get_page_description(OfferView, "new.html", _),
    do:
      gettext(
        "Post your job offer to reach more Elixir developers and find the right hire for your company!"
      )

  defp get_page_description(OfferView, "show.html", %{:offer => %Offer{} = offer}) do
    offer.summary
    |> HtmlSanitizeEx.strip_tags()
    |> String.slice(0, 100)
  end

  defp get_page_description(PageView, "about.html", _),
    do:
      gettext(
        "Built on Elixir + Phoenix, Elixir Jobs is a open source project that aims to help Elixir developers to find their next dream job."
      )

  defp get_page_description(_, _, _), do: gettext(@default_page_description)
end
