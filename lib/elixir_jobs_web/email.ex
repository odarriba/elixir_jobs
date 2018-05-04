defmodule ElixirJobsWeb.Email do
  use Bamboo.Phoenix, view: ElixirJobsWeb.EmailView

  import ElixirJobsWeb.Gettext

  def notification_offer_created_html(offer, from \\ :default) do
    case ElixirJobs.Users.admin_emails() do
      [] ->
        []

      recipients ->
        for recipient <- recipients do
          from
          |> put_basic_layouts(recipient)
          |> subject(gettext("ElixirJobs - A new job offer was received"))
          |> render("offer_created.text", offer: offer)
          |> render("offer_created.html", offer: offer)
          |> ElixirJobsWeb.Mailer.deliver_later()
        end
    end
  end

  defp put_basic_layouts(from, recipient) do
    actual_from = get_from(from)

    new_email()
    |> to(recipient)
    |> from(actual_from)
    |> put_text_layout({ElixirJobsWeb.LayoutView, "email.text"})
    |> put_html_layout({ElixirJobsWeb.LayoutView, "email.html"})
  end

  defp get_from(:default), do: Application.get_env(:elixir_jobs, :default_app_email)
  defp get_from(from), do: from
end
