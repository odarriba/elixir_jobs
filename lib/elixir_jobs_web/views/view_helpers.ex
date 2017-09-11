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
end
