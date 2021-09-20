defmodule ElixirJobsWeb.SitemapController do
  use ElixirJobsWeb, :controller

  alias ElixirJobs.Core

  @items_per_page Application.compile_env!(:elixir_jobs, :items_per_page)

  def sitemap(conn, _params) do
    offers = Core.list_offers(published: true)

    total_pages =
      offers
      |> length()
      |> Kernel./(@items_per_page)
      |> Float.ceil()
      |> round()

    render(conn, "sitemap.xml", total_pages: total_pages, offers: offers)
  end
end
