defmodule ElixirJobsWeb.OfferView do
  use ElixirJobsWeb, :view

  alias ElixirJobs.Offers

  alias ElixirJobsWeb.HumanizeHelper

  def get_job_place_options(default) do
    Enum.reduce(Offers.get_job_places(), [], fn option, acc ->
      select_option = [
        {HumanizeHelper.get_place_text(option, default), option}
      ]

      acc ++ select_option
    end)
  end

  def get_job_type_options(default) do
    Enum.reduce(Offers.get_job_types(), [], fn option, acc ->
      select_option = [
        {HumanizeHelper.get_type_text(option, default), option}
      ]

      acc ++ select_option
    end)
  end
end
