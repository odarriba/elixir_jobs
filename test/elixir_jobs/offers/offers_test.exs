defmodule ElixirJobs.OffersTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Offers

  describe "offers" do
    alias ElixirJobs.{
      Offers.Offer,
      EctoEnums.JobPlace,
      EctoEnums.JobType
    }

    @valid_attrs %{
      title: "some title",
      company: "some company",
      summary: "some summary",
      location: "some location",
      url: "https://www.google.com",
      job_place: "remote",
      job_type: "full_time"
    }
    @update_attrs %{
      title: "some updated title",
      company: "some updated company",
      summary: "some updated summary",
      location: "some updated location",
      url: "https://www.google.es",
      job_place: "onsite",
      job_type: "part_time"
    }
    @invalid_attrs %{
      title: nil,
      company: nil,
      location: nil,
      url: nil,
      job_place: "not_registered",
      job_type: "not_registered"
    }

    def offer_fixture(attrs \\ %{}) do
      {:ok, offer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Offers.create_offer()

      offer
    end

    test "list_offers/0 returns all offers" do
      offer = offer_fixture()
      assert Offers.list_offers() == [offer]
    end

    test "get_offer!/1 returns the offer with given id" do
      offer = offer_fixture()
      assert Offers.get_offer!(offer.id) == offer
    end

    test "create_offer/1 with valid data creates a offer" do
      assert {:ok, %Offer{} = offer} = Offers.create_offer(@valid_attrs)
      assert offer.title == "some title"
      assert offer.company == "some company"
      assert offer.summary == "some summary"
      assert offer.location == "some location"
      assert offer.url == "https://www.google.com"
      assert offer.job_place == :remote
      assert offer.job_type == :full_time
    end

    test "create_offer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Offers.create_offer(@invalid_attrs)
    end

    test "update_offer/2 with valid data updates the offer" do
      offer = offer_fixture()
      assert {:ok, offer} = Offers.update_offer(offer, @update_attrs)
      assert %Offer{} = offer
      assert offer.title == "some updated title"
      assert offer.company == "some updated company"
      assert offer.summary == "some updated summary"
      assert offer.location == "some updated location"
      assert offer.url == "https://www.google.es"
      assert offer.job_place == :onsite
      assert offer.job_type == :part_time
    end

    test "update_offer/2 with invalid data returns error changeset" do
      offer = offer_fixture()
      assert {:error, %Ecto.Changeset{}} = Offers.update_offer(offer, @invalid_attrs)
      assert offer == Offers.get_offer!(offer.id)
    end

    test "delete_offer/1 deletes the offer" do
      offer = offer_fixture()
      assert {:ok, %Offer{}} = Offers.delete_offer(offer)
      assert_raise Ecto.NoResultsError, fn -> Offers.get_offer!(offer.id) end
    end

    test "change_offer/1 returns a offer changeset" do
      offer = offer_fixture()
      assert %Ecto.Changeset{} = Offers.change_offer(offer)
    end

    test "get_job_places/0 returns the expected value" do
      assert Offers.get_job_places() == JobPlace.__enum_map__()
    end

    test "get_job_types/0 returns the expected value" do
      assert Offers.get_job_types() == JobType.__enum_map__()
    end
  end
end
