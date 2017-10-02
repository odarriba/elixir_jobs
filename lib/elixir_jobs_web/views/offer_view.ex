defmodule ElixirJobsWeb.OfferView do
  use ElixirJobsWeb, :view

  alias ElixirJobs.Offers

  def get_job_place_options(default) do
    Enum.reduce(Offers.get_job_places(), [], fn(option, acc) ->
      select_option = [
        {get_place_text(option, default), option}
      ]

      acc ++ select_option
    end)
  end

  def get_job_type_options(default) do
    Enum.reduce(Offers.get_job_types(), [], fn(option, acc) ->
      select_option = [
        {get_type_text(option, default), option}
      ]

      acc ++ select_option
    end)
  end

  def human_get_filter(option, default, :type), do: human_get_type(option, default)
  def human_get_filter(option, default, :place), do: human_get_place(option, default)

  def human_get_place("onsite", default), do: get_place_text(:onsite, default)
  def human_get_place("remote", default), do: get_place_text(:remote, default)
  def human_get_place("both", default), do: get_place_text(:both, default)
  def human_get_place(option, default), do: get_place_text(option, default)

  def human_get_type("full_time", default), do: get_type_text(:full_time, default)
  def human_get_type("part_time", default), do: get_type_text(:part_time, default)
  def human_get_type("freelance", default), do: get_type_text(:freelance, default)
  def human_get_type(option, default), do: get_type_text(option, default)

  defp get_place_text(:onsite, _default), do: gettext("On site")
  defp get_place_text(:remote, _default), do: gettext("Remote")
  defp get_place_text(:both, _default), do: gettext("Onsite / Remote")
  defp get_place_text(_, default), do: default

  defp get_type_text(:full_time, _default), do: gettext("Full time")
  defp get_type_text(:part_time, _default), do: gettext("Part time")
  defp get_type_text(:freelance, _default), do: gettext("Freelance")
  defp get_type_text(_, default), do: default
end
