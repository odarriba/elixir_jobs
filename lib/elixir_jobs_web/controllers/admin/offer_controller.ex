defmodule ElixirJobsWeb.Admin.OfferController do
  use ElixirJobsWeb, :controller

  alias ElixirJobs.{
    Offers,
    Offers.Offer
  }

  plug :scrub_params, "offer" when action in [:update]

  def index_published(conn, params) do
    page_number =
      with {:ok, page_no} <- Map.fetch(params, "page_number"),
           true <- is_binary(page_no),
           {value, _} <- Integer.parse(page_no) do
        value
      else
        _ -> 1
      end

    pages = Offers.list_published_offers(page_number)

    render(conn, "index_published.html",
      offers: pages.entries,
      page_number: pages.page_number,
      total_pages: pages.total_pages)
  end

  def index_unpublished(conn, _params) do
    page_number =
      with {:ok, page_no} <- Map.fetch(params, "page_number"),
           true <- is_binary(page_no),
           {value, _} <- Integer.parse(page_no) do
        value
      else
        _ -> 1
      end

    pages = Offers.list_unpublished_offers(page_number)

    render(conn, "index_unpublished.html",
      offers: pages.entries,
      page_number: pages.page_number,
      total_pages: pages.total_pages)
  end

  def edit(conn, %{"slug" => slug}) do
    offer_changeset =
      slug
      |> Offers.get_offer_by_slug!()
      |> Offers.change_offer()

    render(conn, "edit.html", changeset: offer_changeset)
  end

  def update(conn, %{"slug" => slug, "offer" => offer_params}) do
    slug
    |> Offers.get_offer_by_slug!()
    |> Offers.update_offer(offer_params)
    |> case do
      {:ok, _offer} ->
        conn
        |> put_flash(:info, gettext("<b>Job offer updated correctly!</b>"))
        |> redirect(to: offer_path(conn, :show, slug))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
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
