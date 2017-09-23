defmodule ElixirJobsWeb.SitemapController do
  use ElixirJobsWeb, :controller

  alias ElixirJobs.Offers

  @items_per_page Application.get_env(:elixir_jobs, :items_per_page)

  def sitemap(conn, _params) do
    offers = Offers.list_published_offers()

    total_pages =
      offers
      |> length()
      |> Kernel./(@items_per_page)
      |> Float.ceil()
      |> round()

    render(conn, "sitemap.xml", total_pages: total_pages, offers: offers)
  end
end
