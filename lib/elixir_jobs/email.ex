defmodule ElixirJobsWeb.Email do
  #import Bamboo.Email
  use Bamboo.Phoenix, view: ElixirJobsWeb.EmailView

  def notification_offer_created_html(offer) do
    emails = ElixirJobs.Users.Admin |> ElixirJobs.Users.Queries.Admin.admin_emails |> ElixirJobs.Repo.all
    case emails do
      [] ->
        {:ok}
      _ ->
        notification_offer_created_text(emails, offer)
        |> put_html_layout({ElixirJobsWeb.LayoutView, "email.html"})
        |> render("offer_created.html", offer: offer)
        |> ElixirJobsWeb.Mailer.deliver_later
    end
  end

  def notification_offer_created_text(emails, offer) do
    put_basic_layouts(emails)
    |> subject("A new job offer was posted")
    |> render("offer_created.text", offer: offer)
  end

  defp put_basic_layouts(emails) do
    new_email()
    |> to(emails)
    |> from({"ElixirJobs", "elixirjobs@email.com"})
    |> put_text_layout({ElixirJobsWeb.LayoutView, "email.text"})
  end

end
