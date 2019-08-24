defmodule ElixirJobs.Core.Managers.Offers do
  @moduledoc """
  The Offers context.

  At the moment this context o ly have the Offer schema and functions to manage
  offers in the app.
  """

  alias ElixirJobs.Core.Queries.Offer, as: OfferQuery
  alias ElixirJobs.Core.Schemas.Offer
  alias ElixirJobs.Repo

  @doc """
  Returns the list of offers.

  Accepts some options:

  - page: number of the page. If not passed, no pagination is made.
  - published: returns only published or unpublished offers.
  - job_place: filter offers by job place
  - job_type: filter offers by job type
  - search_text: filter offers by text

  ## Examples

      iex> list_offers()
      [%Offer{}, ...]

      iex> list_offers(page_no)
      [%Offer{}, ...]

  """
  def list_offers(opts \\ Keyword.new()) do
    query = OfferQuery.build(Offer, opts)

    case Keyword.get(opts, :page) do
      page_no when is_integer(page_no) and page_no > 0 ->
        Repo.paginate(query, page: page_no)

      _ ->
        Repo.all(query)
    end
  end

  @doc """
  Gets a single offer.

  Raises `Ecto.NoResultsError` if the Offer does not exist.

  Accepts some options:

  - page: number of the page. If not passed, no pagination is made.
  - published: returns only published or unpublished offers.
  - job_place: filter offers by job place
  - job_type: filter offers by job type
  - search_text: filter offers by text

  ## Examples

      iex> get_offer!(123)
      %Offer{}

      iex> get_offer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_offer!(id, opts \\ Keyword.new()) do
    Offer
    |> OfferQuery.by_id(id)
    |> OfferQuery.build(opts)
    |> Repo.one!()
  end

  @doc """
  Gets a single offer by it's slug.

  Raises `Ecto.NoResultsError` if the Offer does not exist.

  Accepts some options:

  - page: number of the page. If not passed, no pagination is made.
  - published: returns only published or unpublished offers.
  - job_place: filter offers by job place
  - job_type: filter offers by job type
  - search_text: filter offers by text

  ## Examples

      iex> get_offer_by_slug!("existing-slug")
      %Offer{}

      iex> get_offer_by_slug!("non-existent-slug")
      ** (Ecto.NoResultsError)

  """
  def get_offer_by_slug!(slug, opts \\ Keyword.new()) do
    Offer
    |> OfferQuery.by_slug(slug)
    |> OfferQuery.build(opts)
    |> Repo.one!()
  end

  @doc """
  Creates a offer.

  ## Examples

      iex> create_offer(%{field: value})
      {:ok, %Offer{}}

      iex> create_offer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_offer(attrs \\ %{}) do
    %Offer{}
    |> Offer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a offer.

  ## Examples

      iex> update_offer(offer, %{field: new_value})
      {:ok, %Offer{}}

      iex> update_offer(offer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_offer(%Offer{} = offer, attrs) do
    offer
    |> Offer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Publishes an offer.
  Optionally you can provide a publication date

  ## Examples

      iex> publish_offer(offer)
      {:ok, %Offer{}}

      iex> publish_offer(offer, datetime)
      {:ok, %Offer{}}

  """
  def publish_offer(%Offer{} = offer), do: publish_offer(offer, DateTime.utc_now())

  def publish_offer(%Offer{} = offer, date) do
    update_offer(offer, %{published_at: date})
  end

  @doc """
  Deletes a Offer.

  ## Examples

      iex> delete_offer(offer)
      {:ok, %Offer{}}

      iex> delete_offer(offer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_offer(%Offer{} = offer) do
    Repo.delete(offer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking offer changes.

  ## Examples

      iex> change_offer(offer)
      %Ecto.Changeset{source: %Offer{}}

  """
  def change_offer(%Offer{} = offer) do
    Offer.changeset(offer, %{})
  end
end
