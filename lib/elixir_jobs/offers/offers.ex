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
  def list_offers(page \\ nil) do
    query =  OfferQuery.order_inserted(Offer)

    case page do
      page_no when is_integer(page_no) and page_no > 0 ->
        Repo.paginate(query, page: page)

      _ ->
        Repo.all(query)
    end
  end

  @doc """
  Returns the list of published offers.

  ## Examples

      iex> list_published_offers()
      [%Offer{}, ...]

      iex> list_published_offers(page_no)
      [%Offer{}, ...]

  """
  def list_published_offers(page \\ nil) do
    query =
      Offer
      |> OfferQuery.published()
      |> OfferQuery.order_published()

    case page do
      page_no when is_integer(page_no) and page_no > 0 ->
        Repo.paginate(query, page: page)

      _ ->
        Repo.all(query)
    end
  end

  @doc """
  Returns the list of published offers.

  ## Examples

      iex> list_published_offers()
      [%Offer{}, ...]

      iex> list_published_offers(page_no)
      [%Offer{}, ...]

  """
  def filter_published_offers(filters, page \\ nil) do
    job_types = Enum.reduce(get_job_types(), get_job_types(), fn(el, acc) -> acc ++ [to_string(el)] end)
    job_places = Enum.reduce(get_job_places(), get_job_places(), fn(el, acc) -> acc ++ [to_string(el)] end)

    job_type =
      with {:ok, type} <- Map.fetch(filters, "job_type"),
            true <- type in job_types do
        type
      else
        _ -> nil
      end

    job_place =
      with {:ok, place} <- Map.fetch(filters, "job_place"),
            true <- place in job_places do
        place
      else
        _ -> nil
      end

    text = Map.get(filters, "text", nil)

    query =
      Offer
      |> OfferQuery.published()
      |> OfferQuery.order_published()
      |> OfferQuery.by_job_type(job_type)
      |> OfferQuery.by_job_place(job_place)
      |> OfferQuery.by_text(text)

    case page do
      page_no when is_integer(page_no) and page_no > 0 ->
        Repo.paginate(query, page: page)

      _ ->
        Repo.all(query)
    end
  end

  @doc """
  Returns the list of unpublished offers.

  ## Examples

      iex> list_unpublished_offers()
      [%Offer{}, ...]

      iex> list_unpublished_offers(page_no)
      [%Offer{}, ...]

  """
  def list_unpublished_offers(page \\ nil) do
    query =
      Offer
      |> OfferQuery.unpublished()
      |> OfferQuery.order_inserted()

    case page do
      page_no when is_integer(page_no) and page_no > 0 ->
        Repo.paginate(query, page: page)

      _ ->
        Repo.all(query)
    end
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
  Gets a single published offer by it's slug.

  Raises `Ecto.NoResultsError` if the Offer does not exist.

  ## Examples

      iex> get_published_offer_by_slug!("existing-slug")
      %Offer{}

      iex> get_published_offer_by_slug!("non-existent-slug")
      ** (Ecto.NoResultsError)

  """
  def get_published_offer_by_slug!(slug) do
    Offer
    |> OfferQuery.by_slug(slug)
    |> OfferQuery.published()
    |> Repo.one!()
  end

  @doc """
  Gets a single offer by it's slug.

  Raises `Ecto.NoResultsError` if the Offer does not exist.

  ## Examples

      iex> get_offer_by_slug!("existing-slug")
      %Offer{}

      iex> get_offer_by_slug!("non-existent-slug")
      ** (Ecto.NoResultsError)

  """
  def get_offer_by_slug!(slug) do
    Offer
    |> OfferQuery.by_slug(slug)
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
  Unpublishes an offer.

  ## Examples

      iex> unpublish_offer(offer)
      {:ok, %Offer{}}

  """
  def unpublish_offer(%Offer{} = offer) do
    update_offer(offer, %{published_at: nil})
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
