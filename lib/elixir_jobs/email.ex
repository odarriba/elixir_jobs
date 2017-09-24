defmodule ElixirJobsWeb.Email do
  use Bamboo.Phoenix, view: ElixirJobsWeb.EmailView

  def notification_offer_created_html({offer, from}) do
    case ElixirJobs.Users.admin_emails do
      [] ->
        {:ok}
      recipients ->
        put_basic_layouts({from, recipients})
        |> subject("A new job offer was posted")
        |> render("offer_created.html", offer: offer)
        |> ElixirJobsWeb.Mailer.deliver_later
    end
  end

  defp put_basic_layouts({from, recipients}) do
    new_email()
    |> bcc(recipients)
    |> put_text_layout({ElixirJobsWeb.LayoutView, "email.text"})
    |> put_html_layout({ElixirJobsWeb.LayoutView, "email.html"})
    |> put_from(from)
  end

  defp put_from(email, :default) do
    email |> from(Application.get_env(:elixir_jobs, :default_app_email))
  end

  defp put_from(email, from) do
    email |> from(from)
  end

end
