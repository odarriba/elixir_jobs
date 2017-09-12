defmodule ElixirJobsWeb.OfferView do
  use ElixirJobsWeb, :view

  alias ElixirJobs.Offers

  def get_job_place_options do
    Enum.reduce(Offers.get_job_places(), [], fn(option, acc) ->
      select_option = [
        {get_place_text(option), option}
      ]

      acc ++ select_option
    end)
  end

  def get_job_type_options do
    Enum.reduce(Offers.get_job_types(), [], fn(option, acc) ->
      select_option = [
        {get_type_text(option), option}
      ]

      acc ++ select_option
    end)
  end

  def human_get_place(:unknown), do: gettext("Not specified")
  def human_get_place(option), do: get_place_text(option)

  def human_get_type(:unknown), do: gettext("Not specified")
  def human_get_type(option), do: get_type_text(option)

  defp get_place_text(:unknown), do: gettext("Select a job place")
  defp get_place_text(:onsite), do: gettext("Onsite")
  defp get_place_text(:remote), do: gettext("Remote")
  defp get_place_text(:both), do: gettext("Onsite / Remote")
  defp get_place_text(option), do: to_string(option)

  defp get_type_text(:unknown), do: gettext("Select a job type")
  defp get_type_text(:full_time), do: gettext("Full time")
  defp get_type_text(:part_time), do: gettext("Part time")
  defp get_type_text(:freelance), do: gettext("Freelance")
  defp get_type_text(option), do: to_string(option)
end
