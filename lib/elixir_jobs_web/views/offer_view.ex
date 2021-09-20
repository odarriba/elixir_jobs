defmodule ElixirJobsWeb.OfferView do
  use ElixirJobsWeb, :view

  alias ElixirJobs.Core
  alias ElixirJobs.Core.Schemas.Offer

  alias ElixirJobsWeb.HumanizeHelper

  @utm_params [
    {"utm_source", "elixirjobs.net"},
    {"utm_medium", "job_board"},
    {"utm_campaign", "elixirjobs.net"}
  ]

  def get_job_place_options(default) do
    Enum.reduce(Core.get_job_places(), [], fn option, acc ->
      select_option = [
        {HumanizeHelper.get_place_text(option, default), option}
      ]

      acc ++ select_option
    end)
  end

  def get_job_type_options(default) do
    Enum.reduce(Core.get_job_types(), [], fn option, acc ->
      select_option = [
        {HumanizeHelper.get_type_text(option, default), option}
      ]

      acc ++ select_option
    end)
  end

  def offer_url(%Offer{url: url}) do
    parsed_url = URI.parse(url)

    query = parsed_url.query || ""

    query_params =
      query
      |> URI.query_decoder()
      |> Enum.reject(fn
        {"utm_source", _} -> true
        {"utm_medium", _} -> true
        {"utm_campaign", _} -> true
        _ -> false
      end)
      |> Kernel.++(@utm_params)
      |> URI.encode_query()

    URI.to_string(%{parsed_url | query: query_params})
  end
end
