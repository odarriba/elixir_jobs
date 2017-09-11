defmodule ElixirJobsWeb.ViewHelpers do
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
end
