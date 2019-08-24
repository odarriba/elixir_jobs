defmodule ElixirJobs.Core.Managers.OfferTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Core.Managers.Offer, as: Manager
  alias ElixirJobs.Core.Schemas.Offer

  describe "Offer.list_offers/0" do
    test "returns all offers" do
      offer_1 = insert(:offer)
      offer_2 = insert(:offer)

      result = Manager.list_offers()

      assert offer_1 in result
      assert offer_2 in result
    end
  end

  describe "Offer.list_offers/1" do
    test "returns paginated offers" do
      Enum.map(1..20, fn _ -> insert(:offer) end)

      result = Manager.list_offers(page: 2)

      assert length(result.entries) == 10
      assert result.total_pages == 2
      assert result.page_number == 2
    end

    test "returns published offers" do
      offer_1 = insert(:offer, published_at: DateTime.utc_now())
      offer_2 = insert(:offer, published_at: nil)

      result = Manager.list_offers(published: true)

      assert offer_1 in result
      refute offer_2 in result
    end

    test "returns unpublished offers" do
      offer_1 = insert(:offer, published_at: DateTime.utc_now())
      offer_2 = insert(:offer, published_at: nil)

      result = Manager.list_offers(published: false)

      refute offer_1 in result
      assert offer_2 in result
    end

    test "returns offers by job type" do
      offer_1 = insert(:offer, job_type: :full_time)
      offer_2 = insert(:offer, job_type: :part_time)

      result = Manager.list_offers(job_type: :full_time)

      assert offer_1 in result
      refute offer_2 in result
    end

    test "returns offers by job place" do
      offer_1 = insert(:offer, job_place: :onsite)
      offer_2 = insert(:offer, job_place: :remote)

      result = Manager.list_offers(job_place: :onsite)

      assert offer_1 in result
      refute offer_2 in result
    end

    test "returns offers that matches a text" do
      offer_1 =
        insert(:offer,
          title: "Elixir Developer",
          company: "Acme Co.",
          location: "Barcelona",
          summary: "My awesome summary text"
        )

      offer_2 = insert(:offer)

      # By title
      result = Manager.list_offers(search_text: "developer")

      assert offer_1 in result
      refute offer_2 in result

      # By company
      result = Manager.list_offers(search_text: "acm")

      assert offer_1 in result
      refute offer_2 in result

      # By location
      result = Manager.list_offers(search_text: "barcel")

      assert offer_1 in result
      refute offer_2 in result

      # By summary
      result = Manager.list_offers(search_text: "aweso")

      assert offer_1 in result
      refute offer_2 in result
    end
  end

  describe "Offer.get_offer!/1" do
    test "returns the offer with given id" do
      offer_1 = insert(:offer)
      offer_2 = insert(:offer)

      assert Manager.get_offer!(offer_1.id) == offer_1
      assert Manager.get_offer!(offer_2.id) == offer_2
    end

    test "raises an exception if no offer is found with that ID" do
      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer!(Ecto.UUID.generate())
      end
    end
  end

  describe "Offer.get_offer!/2" do
    test "returns published offer by ID" do
      offer_1 = insert(:offer, published_at: DateTime.utc_now())
      offer_2 = insert(:offer, published_at: nil)

      assert Manager.get_offer!(offer_1.id, published: true) == offer_1

      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer!(offer_2.id, published: true)
      end
    end

    test "returns unpublished offer by ID" do
      offer_1 = insert(:offer, published_at: DateTime.utc_now())
      offer_2 = insert(:offer, published_at: nil)

      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer!(offer_1.id, published: false)
      end

      assert Manager.get_offer!(offer_2.id, published: false) == offer_2
    end

    test "returns offer by ID and job type" do
      offer_1 = insert(:offer, job_type: :full_time)
      offer_2 = insert(:offer, job_type: :part_time)

      assert Manager.get_offer!(offer_1.id, job_type: :full_time) == offer_1

      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer!(offer_2.id, job_type: :full_time)
      end
    end

    test "returns offer by ID and job place" do
      offer_1 = insert(:offer, job_place: :onsite)
      offer_2 = insert(:offer, job_place: :remote)

      assert Manager.get_offer!(offer_1.id, job_place: :onsite) == offer_1

      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer!(offer_2.id, job_place: :onsite)
      end
    end
  end

  describe "Offer.get_offer_by_slug!/1" do
    test "returns the offer with given id" do
      offer_1 = insert(:offer)
      offer_2 = insert(:offer)

      assert Manager.get_offer_by_slug!(offer_1.slug) == offer_1
      assert Manager.get_offer_by_slug!(offer_2.slug) == offer_2
    end

    test "raises an exception if no offer is found with that slug" do
      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer_by_slug!("non-existent-slug")
      end
    end
  end

  describe "Offer.get_offer_by_slug!/2" do
    test "returns published offer by slug" do
      offer_1 = insert(:offer, published_at: DateTime.utc_now())
      offer_2 = insert(:offer, published_at: nil)

      assert Manager.get_offer_by_slug!(offer_1.slug, published: true) == offer_1

      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer_by_slug!(offer_2.slug, published: true)
      end
    end

    test "returns unpublished offer by slug" do
      offer_1 = insert(:offer, published_at: DateTime.utc_now())
      offer_2 = insert(:offer, published_at: nil)

      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer_by_slug!(offer_1.slug, published: false)
      end

      assert Manager.get_offer_by_slug!(offer_2.slug, published: false) == offer_2
    end

    test "returns offer by slug and job type" do
      offer_1 = insert(:offer, job_type: :full_time)
      offer_2 = insert(:offer, job_type: :part_time)

      assert Manager.get_offer_by_slug!(offer_1.slug, job_type: :full_time) == offer_1

      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer_by_slug!(offer_2.slug, job_type: :full_time)
      end
    end

    test "returns offer by slug and job place" do
      offer_1 = insert(:offer, job_place: :onsite)
      offer_2 = insert(:offer, job_place: :remote)

      assert Manager.get_offer_by_slug!(offer_1.slug, job_place: :onsite) == offer_1

      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer_by_slug!(offer_2.slug, job_place: :onsite)
      end
    end
  end

  describe "Offer.create_offer/1" do
    test "with valid data creates an portal" do
      offer_data = params_for(:offer)

      {result, resource} = Manager.create_offer(offer_data)

      assert result == :ok
      assert %Offer{} = resource
      assert resource == Manager.get_offer!(resource.id)
    end

    test "with invalid data returns error changeset" do
      offer_data = params_for(:offer, title: "")

      {result, resource} = Manager.create_offer(offer_data)

      assert result == :error
      assert %Ecto.Changeset{} = resource
    end
  end

  describe "Offer.update_offer/2" do
    test "with valid data updates the offer" do
      offer = insert(:offer)

      new_offer_data = %{
        title: "This is an updated title"
      }

      {result, resource} = Manager.update_offer(offer, new_offer_data)

      assert result == :ok
      assert %Offer{} = resource
      refute resource.title == offer.title
      assert resource.title == new_offer_data[:title]
    end

    test "with invalid data returns error changeset" do
      offer = insert(:offer)
      new_offer_data = %{title: ""}

      {result, resource} = Manager.update_offer(offer, new_offer_data)

      assert result == :error
      assert %Ecto.Changeset{} = resource
      assert Enum.any?(resource.errors, fn {k, _v} -> k == :title end)
    end
  end

  describe "Offer.publish_offer/1" do
    test "publishes the offer" do
      offer = insert(:offer, published_at: nil)

      {result, resource} = Manager.publish_offer(offer)

      assert result == :ok
      assert %Offer{} = resource

      refute resource.published_at == nil
      assert resource.published_at < DateTime.utc_now()
    end
  end

  describe "Offer.publish_offer/2" do
    test "publishes the offer at a specified time" do
      offer = insert(:offer, published_at: nil)

      time =
        DateTime.utc_now()
        |> DateTime.truncate(:second)

      {result, resource} = Manager.publish_offer(offer, time)

      assert result == :ok
      assert %Offer{} = resource
      assert resource.published_at == time
    end
  end

  describe "Offer.delete_offer/1" do
    test "deletes the offer" do
      offer = insert(:offer)

      assert Manager.get_offer!(offer.id) == offer
      assert {:ok, offer} = Manager.delete_offer(offer)

      assert_raise Ecto.NoResultsError, fn ->
        Manager.get_offer!(offer.id)
      end
    end
  end

  describe "Offer.change_offer/1" do
    test "generates a changeset" do
      offer = insert(:offer, published_at: nil)
      assert %Ecto.Changeset{} = Manager.change_offer(offer)
    end
  end
end
