defmodule ElixirJobsWeb.ViewHelpers do
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
    |> Enum.map(fn({attr, _message}) -> attr end)
    |> Enum.member?(field)
  end

  def sanitized_markdown(nil), do: ""
  def sanitized_markdown(text) do
    text
    |> Earmark.as_html!
    |> sanitize
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

  defp this_year?(date), do: date.year == Ecto.DateTime.utc.year

  defp today?(date) do
    now = Ecto.DateTime.utc
    date.day == now.day && date.month == now.month && date.year == now.year
  end

  def yesterday?(date) do
    now = Ecto.DateTime.utc
    difference = ElixirJobs.Date.diff(now, date)
    difference < 2 * 24 * 60 * 60 && difference > 1 * 24 * 60 * 60
  end
end
