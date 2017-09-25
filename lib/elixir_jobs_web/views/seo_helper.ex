defmodule ElixirJobsWeb.SeoHelper do
  use ElixirJobsWeb, :view

  import Phoenix.Controller, only: [controller_module: 1, action_name: 1]

  @default_page_title "Find your next job the right way"
  @default_page_description "ElixirJobs helps developers to find their next Elixir job and companies to spread their offers."

  alias ElixirJobs.Offers.Offer

  alias ElixirJobsWeb.{
    OfferController,
    PageController
  }

  def page_title(%Plug.Conn{} = conn) do
    get_page_title(controller_module(conn), action_name(conn), conn.assigns)
  end
  def page_title(_), do: gettext(@default_page_title)

  def page_description(%Plug.Conn{} = conn) do
    get_page_description(controller_module(conn), action_name(conn), conn.assigns)
  end
  def page_description(_), do: gettext(@default_page_description)

  defp get_page_title(OfferController, :new, _), do: gettext("Publish a job offer")
  defp get_page_title(OfferController, :show, %{:offer => %Offer{} = offer}), do: "#{offer.title} @ #{offer.company}"
  defp get_page_title(PageController, :about, _), do: gettext("About")
  defp get_page_title(AuthCOntroller, action, _) when action in [:new, :create], do: gettext("Log in")
  defp get_page_title(_, _, _), do: gettext(@default_page_title)

  defp get_page_description(OfferController, :new, _), do: gettext("Post your job offer to reach more Elixir developers and find the right hire for your company!")
  defp get_page_description(OfferController, :show, %{:offer => %Offer{} = offer}) do
    offer.description
    |> Earmark.as_html!()
    |> HtmlSanitizeEx.strip_tags()
    |> String.slice(0, 100)
  end
  defp get_page_description(_, _, _), do: gettext(@default_page_description)
end
