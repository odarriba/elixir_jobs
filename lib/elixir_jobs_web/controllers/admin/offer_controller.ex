defmodule ElixirJobsWeb.Admin.OfferController do
  use ElixirJobsWeb, :controller

  alias ElixirJobs.Offers
  alias ElixirJobsWeb.Twitter
  alias ElixirJobsWeb.Telegram

  plug :scrub_params, "offer" when action in [:update]

  def index_published(conn, params) do
    page_number =
      with {:ok, page_no} <- Map.fetch(params, "page"),
           true <- is_binary(page_no),
           {value, _} <- Integer.parse(page_no) do
        value
      else
        _ -> 1
      end

    pages = Offers.list_published_offers(page_number)

    conn
    |> assign(:offers, pages.entries)
    |> assign(:page_number, pages.page_number)
    |> assign(:total_pages, pages.total_pages)
    |> render("index_published.html")
  end

  def index_unpublished(conn, params) do
    page_number =
      with {:ok, page_no} <- Map.fetch(params, "page"),
           true <- is_binary(page_no),
           {value, _} <- Integer.parse(page_no) do
        value
      else
        _ -> 1
      end

    pages = Offers.list_unpublished_offers(page_number)

    conn
    |> assign(:offers, pages.entries)
    |> assign(:page_number, pages.page_number)
    |> assign(:total_pages, pages.total_pages)
    |> render("index_unpublished.html")
  end

  def publish(conn, %{"slug" => slug}) do
    slug
    |> Offers.get_offer_by_slug!()
    |> Offers.publish_offer()
    |> case do
      {:ok, offer} ->
        Twitter.publish(conn, offer)

        conn
        |> put_flash(:info, gettext("<b>Offer published correctly!</b>"))
        |> redirect(to: offer_path(conn, :show, slug))

      {:error, _} ->
        conn
        |> put_flash(:info, gettext("<b>An error occurred while publishing the offer</b>"))
        |> redirect(to: admin_offer_path(conn, :index_unpublished))
    end
  end

  def send_twitter(conn, %{"slug" => slug}) do
    offer = Offers.get_offer_by_slug!(slug)

    Twitter.publish(conn, offer)

    conn
    |> put_flash(:info, gettext("<b>Offer correctly sent to Twitter account!</b>"))
    |> redirect(to: offer_path(conn, :show, slug))
  end

  def send_telegram(conn, %{"slug" => slug}) do
    offer = Offers.get_offer_by_slug!(slug)

    case Telegram.send(conn, offer) do
      :ok ->
        conn
        |> put_flash(:info, gettext("<b>Offer correctly sent to Telegram channel!</b>"))
        |> redirect(to: offer_path(conn, :show, slug))

      error ->
        raise error
    end
  end

  def edit(conn, %{"slug" => slug}) do
    offer = Offers.get_offer_by_slug!(slug)
    offer_changeset = Offers.change_offer(offer)

    render(conn, "edit.html", changeset: offer_changeset, offer: offer)
  end

  def update(conn, %{"slug" => slug, "offer" => offer_params}) do
    offer = Offers.get_offer_by_slug!(slug)

    case Offers.update_offer(offer, offer_params) do
      {:ok, offer} ->
        conn
        |> put_flash(:info, gettext("<b>Job offer updated correctly!</b>"))
        |> redirect(to: offer_path(conn, :show, offer.slug))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, offer: offer)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    slug
    |> Offers.get_offer_by_slug!()
    |> Offers.delete_offer()
    |> case do
      {:ok, _} ->
        conn
        |> put_flash(:info, gettext("<b>Job offer removed correctly!</b>"))
        |> redirect(to: admin_offer_path(conn, :index_published))

      {:error, _} ->
        conn
        |> put_flash(:error, gettext("<b>Job offer couldn't be removed correctly!</b>"))
        |> redirect(to: offer_path(conn, :show, slug))
    end
  end
end
