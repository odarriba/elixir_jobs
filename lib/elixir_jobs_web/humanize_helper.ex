defmodule ElixirJobsWeb.HumanizeHelper do
  @moduledoc false

  import ElixirJobsWeb.Gettext

  def human_get_place("onsite", default), do: get_place_text(:onsite, default)
  def human_get_place("remote", default), do: get_place_text(:remote, default)
  def human_get_place("both", default), do: get_place_text(:both, default)
  def human_get_place(option, default), do: get_place_text(option, default)

  def human_get_type("full_time", default), do: get_type_text(:full_time, default)
  def human_get_type("part_time", default), do: get_type_text(:part_time, default)
  def human_get_type("freelance", default), do: get_type_text(:freelance, default)
  def human_get_type(option, default), do: get_type_text(option, default)

  def get_place_text(:onsite, _default), do: gettext("On site")
  def get_place_text(:remote, _default), do: gettext("Remote")
  def get_place_text(:both, _default), do: gettext("Onsite / Remote")
  def get_place_text(_, default), do: default

  def get_type_text(:full_time, _default), do: gettext("Full time")
  def get_type_text(:part_time, _default), do: gettext("Part time")
  def get_type_text(:freelance, _default), do: gettext("Freelance")
  def get_type_text(_, default), do: default
end
