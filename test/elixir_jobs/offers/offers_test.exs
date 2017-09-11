defmodule ElixirJobs.OffersTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Offers

  describe "offers" do
    alias ElixirJobs.Offers.Offer

    @valid_attrs %{description: "some description", title: "some title", url: "some url"}
    @update_attrs %{description: "some updated description", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{description: nil, title: nil, url: nil}

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
      assert offer.description == "some description"
      assert offer.title == "some title"
      assert offer.url == "some url"
    end

    test "create_offer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Offers.create_offer(@invalid_attrs)
    end

    test "update_offer/2 with valid data updates the offer" do
      offer = offer_fixture()
      assert {:ok, offer} = Offers.update_offer(offer, @update_attrs)
      assert %Offer{} = offer
      assert offer.description == "some updated description"
      assert offer.title == "some updated title"
      assert offer.url == "some updated url"
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
  end
end
