defmodule ElixirJobsWeb.EmailsTest do
  use ElixirJobsWeb.ConnCase
  use Bamboo.Test, shared: true

  alias ElixirJobs.Core

  import Ecto.Query, only: [from: 2]

  describe "offers" do
    test "emails get sent to admins on offer creation", %{conn: conn} do
      insert(:admin)
      insert(:admin)

      post conn, offer_path(conn, :create), offer: params_for(:offer)

      query =
        from offer in Core.Schemas.Offer,
          order_by: [desc: offer.inserted_at],
          limit: 1

      offer = ElixirJobs.Repo.one(query)

      for {:ok, email} <- ElixirJobsWeb.Email.notification_offer_created_html(offer) do
        assert_delivered_email(email)
      end
    end

    test "doesn't raise error without admins on offer creation", %{conn: conn} do
      conn = post conn, offer_path(conn, :create), offer: params_for(:offer)

      assert redirected_to(conn) == offer_path(conn, :new)

      assert get_flash(conn, :info) ==
               "<b>Job offer successfully sent!</b> We will review and publish it soon"

      assert_no_emails_delivered()
    end
  end
end
