defmodule ElixirJobsWeb.Email do
  use Bamboo.Phoenix, view: ElixirJobsWeb.EmailView

  import ElixirJobsWeb.Gettext

  def notification_offer_created_html({offer, from}) do
    case ElixirJobs.Users.admin_emails do
      [] ->
        {:ok}
      recipients ->
        for recipient <- recipients do
          put_basic_layouts({from, recipient})
          |> subject(gettext("ElixirJobs - A new job offer was received"))
          |> render("offer_created.text", offer: offer)
          |> render("offer_created.html", offer: offer)
          |> ElixirJobsWeb.Mailer.deliver_later
        end
    end
  end

  defp put_basic_layouts({from, recipient}) do
    new_email()
    |> to(recipient)
    |> put_from(from)
    |> put_text_layout({ElixirJobsWeb.LayoutView, "email.text"})
    |> put_html_layout({ElixirJobsWeb.LayoutView, "email.html"})
  end

  defp put_from(email, :default) do
    from(email, Application.get_env(:elixir_jobs, :default_app_email))
  end

  defp put_from(email, from) do
    from(email, from)
  end

end
