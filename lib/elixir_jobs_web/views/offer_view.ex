defmodule ElixirJobsWeb.OfferView do
  use ElixirJobsWeb, :view

  alias ElixirJobs.Offers

  import ElixirJobsWeb.HumanizeHelper,
    only: [get_place_text: 2, get_type_text: 2, human_get_place: 2, human_get_type: 2]

  def get_job_place_options(default) do
    Enum.reduce(Offers.get_job_places(), [], fn option, acc ->
      select_option = [
        {get_place_text(option, default), option}
      ]

      acc ++ select_option
    end)
  end

  def get_job_type_options(default) do
    Enum.reduce(Offers.get_job_types(), [], fn option, acc ->
      select_option = [
        {get_type_text(option, default), option}
      ]

      acc ++ select_option
    end)
  end
end
