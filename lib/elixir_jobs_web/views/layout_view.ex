defmodule ElixirJobsWeb.LayoutView do
  use ElixirJobsWeb, :view

  alias ElixirJobsWeb.SeoHelper

  import Phoenix.Controller, only: [current_url: 1, controller_module: 1, action_name: 1]

  def render_microdata(%Plug.Conn{} = conn) do
    case get_microdata(conn, controller_module(conn), action_name(conn)) do
      microdata when is_map(microdata) ->
        "<script type=\"application/ld+json\">#{Poison.encode!(microdata)}</script>"

      microdatas when is_list(microdatas) ->
        microdatas
        |> Enum.map(&("<script type=\"application/ld+json\">#{Poison.encode!(&1)}</script>"))
        |> Enum.join("")

      _ ->
        ""
    end
  end

  defp get_microdata(%Plug.Conn{request_path: "/"} = conn, _, _) do
    url =
      conn
      |> offer_url(:search, [filters: [text: "search_term_string"]])
      |> String.replace("search_term_string", "{search_term_string}")

    [
      %{
        "@context" => "http://schema.org",
        "@type" => "WebSite",
        "url" => ElixirJobsWeb.Endpoint.url() <> "/",
        "potentialAction" => %{
          "@type" => "SearchAction",
          "target" => url,
          "query-input" => "required name=search_term_string"
        }
      }
    ]
    |> Kernel.++([get_organization(conn)])
  end

  defp get_organization(conn) do
    %{
      "url" => ElixirJobsWeb.Endpoint.url() <> "/",
      "sameAs" => ["https://twitter.com/jobs_elixir"],
      "name" => gettext("ElixirJobs"),
      "image" => static_url(conn, "/images/logo.png"),
      "@type" => "Organization",
      "@context" => "http://schema.org"
    }
  end
end
