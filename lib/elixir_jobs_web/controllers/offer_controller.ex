defmodule ElixirJobsWeb.OfferController do
  use ElixirJobsWeb, :controller

  alias ElixirJobs.{
    Offers,
    Offers.Offer
  }

  plug :scrub_params, "offer" when action in [:create, :preview]

  def index(conn, params) do
    page_number =
      with {:ok, page_no} <- Map.fetch(params, "page"),
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

  def search(conn, params) do
    page_number =
      with {:ok, page_no} <- Map.fetch(params, "page"),
           true <- is_binary(page_no),
           {value, _} <- Integer.parse(page_no) do
        value
      else
        _ -> 1
      end

    page = Offers.list_published_offers(page_number)

    render(conn, "search.html",
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

  def preview(conn, %{"offer" => offer_params}) do
    job_place =
      offer_params
      |> Map.get("job_place")
      |> Kernel.||("unknown")
      |> String.to_existing_atom

    job_type =
      offer_params
      |> Map.get("job_type")
      |> Kernel.||("unknown")
      |> String.to_existing_atom

    offer_preview = %Offer{
      title: Map.get(offer_params, "title") || gettext("Title of your offer"),
      company: Map.get(offer_params, "company") || gettext("Company"),
      description: Map.get(offer_params, "description") || gettext("Description of your offer"),
      location: Map.get(offer_params, "location") || gettext("Location"),
      url: Map.get(offer_params, "url") || "https://example.com",
      slug: "",
      job_place: job_place,
      job_type: job_type,
      published_at: Ecto.DateTime.utc()
    }

    conn
    |> put_layout(false)
    |> render("preview.html", offer: offer_preview)
  end

  def show(conn, %{"slug" => slug}) do
    offer = if user_logged_in?(conn) do
      Offers.get_offer_by_slug!(slug)
    else
      Offers.get_published_offer_by_slug!(slug)
    end

    render(conn, "show.html", offer: offer)
  end

  def rss(conn, _params) do
    offers = Offers.list_offers(1)
    render(conn, "rss.xml", offers: offers.entries)
  end
end
