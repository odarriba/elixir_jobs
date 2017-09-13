defmodule ElixirJobs.Offers do
  @moduledoc """
  The Offers context.

  At the moment this context o ly have the Offer schema and functions to manage
  offers in the app.
  """

  alias ElixirJobs.Offers.Queries.Offer, as: OfferQuery

  alias ElixirJobs.{
    Offers.Offer,
    EctoEnums.JobPlace,
    EctoEnums.JobType,
    Repo
  }

  @doc """
  Returns the list of offers.

  ## Examples

      iex> list_offers()
      [%Offer{}, ...]

      iex> list_offers(page_no)
      [%Offer{}, ...]

  """
  def list_offers do
    Offer
    |> OfferQuery.order_inserted()
    |> Repo.all()
  end
  def list_offers(page) when is_integer(page) and page > 0 do
    Offer
    |> OfferQuery.order_inserted()
    |> Repo.paginate(page: page)
  end

  @doc """
  Returns the list of published offers.

  ## Examples

      iex> list_publsihed_offers()
      [%Offer{}, ...]

      iex> list_publsihed_offers(page_no)
      [%Offer{}, ...]

  """
  def list_published_offers do
    Offer
    |> OfferQuery.published()
    |> OfferQuery.order_published()
    |> Repo.all()
  end
  def list_published_offers(page) when is_integer(page) and page > 0 do
    Offer
    |> OfferQuery.published()
    |> OfferQuery.order_published()
    |> Repo.paginate(page: page)
  end

  @doc """
  Gets a single offer.

  Raises `Ecto.NoResultsError` if the Offer does not exist.

  ## Examples

      iex> get_offer!(123)
      %Offer{}

      iex> get_offer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_offer!(id) do
    Offer
    |> OfferQuery.by_id(id)
    |> Repo.one!()
  end

  @doc """
  Gets a single offer by it's sluf.

  Raises `Ecto.NoResultsError` if the Offer does not exist.

  ## Examples

      iex> get_offer!("existing-slug")
      %Offer{}

      iex> get_offer!("non-existent-slug")
      ** (Ecto.NoResultsError)

  """
  def get_offer_by_slug!(slug) do
    Offer
    |> OfferQuery.by_slug(slug)
    |> OfferQuery.published()
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

      iex> publish_offer(offer, ~N[2002-01-13 23:00:07])
      {:ok, %Offer{}}

  """
  def publish_offer(%Offer{} = offer), do: publish_offer(offer, NaiveDateTime.utc_now())
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



  @doc """
  Returns registered job palces.

  ## Examples

      iex> get_job_places()
      [:unknown, :onsite, :remote, :both]

  """
  def get_job_places, do: JobPlace.__enum_map__()

  @doc """
  Returns registered job types.

  ## Examples

      iex> get_job_types()
      [:unknown, :full_time, :part_time, :freelance]

  """
  def get_job_types, do: JobType.__enum_map__()
end
