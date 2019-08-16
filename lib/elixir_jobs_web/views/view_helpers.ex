defmodule ElixirJobsWeb.ViewHelpers do
  @moduledoc """
  Module with helpers commonly used in other views.
  """

  use PhoenixHtmlSanitizer, :markdown_html

  def class_with_error(form, field, base_class) do
    if error_on_field?(form, field) do
      "#{base_class} error"
    else
      base_class
    end
  end

  def error_on_field?(form, field) do
    form.errors
    |> Enum.map(fn {attr, _message} -> attr end)
    |> Enum.member?(field)
  end

  def do_strip_tags(text) do
    sanitize(text, :strip_tags)
  end

  ###
  # XML related functions
  ###

  def xml_strip_tags(text) do
    {:safe, text} = do_strip_tags(text)
    text
  end

  @doc "Returns a date formatted for humans."
  def human_readable_date(date, use_abbrevs? \\ true) do
    if use_abbrevs? && this_year?(date) do
      cond do
        today?(date) ->
          "Today"

        yesterday?(date) ->
          "Yesterday"

        true ->
          ElixirJobs.Date.strftime(date, "%e %b")
      end
    else
      ElixirJobs.Date.strftime(date, "%e %b %Y")
    end
  end

  @doc "Returns a date formatted for RSS clients."
  def xml_readable_date(date) do
    ElixirJobs.Date.strftime(date, "%e %b %Y %T %z")
  end

  ###
  # Private functions
  ###

  defp this_year?(date), do: date.year == DateTime.utc_now().year

  defp today?(date) do
    now = DateTime.utc_now()
    date.day == now.day && date.month == now.month && date.year == now.year
  end

  def yesterday?(date) do
    now = DateTime.utc_now()
    difference = DateTime.diff(now, date)
    difference < 2 * 24 * 60 * 60 && difference > 1 * 24 * 60 * 60
  end
end
