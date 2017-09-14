defmodule ElixirJobsWeb.OfferController do
  use ElixirJobsWeb, :controller

  alias ElixirJobs.{
    Offers,
    Offers.Offer
  }

  plug :scrub_params, "offer" when action in [:create]

  def index(conn, params) do
    page_number =
      with {:ok, page_no} <- Map.fetch(params, "page_number"),
           true <- is_binary(page_no),
           {value, _} <- Integer.parse(page_no) do
        value
      else
        _ -> 1
      end

    page = Offers.list_published_offers(page_number)

    render(conn, "index.html",
      offers: page.entries,
      page_number: page.page_number,
      total_pages: page.total_pages)
  end

  def new(conn, _params) do
    changeset = Offers.change_offer(%Offer{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"offer" => offer_params}) do
    case Offers.create_offer(offer_params) do
      {:ok, _offer} ->
        conn
        |> put_flash(:info, gettext("<b>Job offer created correctly!</b> We will review and publish it soon"))
        |> redirect(to: offer_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug}) do
    offer = Offers.get_offer_by_slug!(slug)
    render(conn, "show.html", offer: offer)
  end

  def rss(conn, _params) do
    offers = Offers.list_offers(1)
    render(conn, "rss.xml", offers: offers.entries)
  end
end
