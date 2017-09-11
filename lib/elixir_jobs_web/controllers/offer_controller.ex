defmodule ElixirJobsWeb.OfferController do
  use ElixirJobsWeb, :controller

  alias ElixirJobs.Offers

  def index(conn, params) do
    page_number =
      with {:ok, page_no} <- Map.fetch(params, "page_number"),
           true <- is_binary(page_no),
           {value, _} <- Integer.parse(page_no) do
        value
      else
        _ -> 1
      end

    page = Offers.list_offers(page_number)

    render conn, "index.html",
      offers: page.entries,
      page_number: page.page_number,
      total_pages: page.total_pages
  end
end
