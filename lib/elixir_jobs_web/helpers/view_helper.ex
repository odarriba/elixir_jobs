defmodule ElixirJobsWeb.ViewHelper do
  @moduledoc """
  Module with helpers commonly used in other views.
  """

  alias ElixirJobsWeb.DateHelper

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
    text
    |> HtmlSanitizeEx.strip_tags()
    |> Phoenix.HTML.raw()
  end

  ###
  # XML related functions
  ###

  def xml_strip_tags(text) do
    {:safe, text} = do_strip_tags(text)
    text
  end

  @doc "Returns a date formatted for RSS clients."
  def xml_readable_date(date) do
    DateHelper.strftime(date, "%e %b %Y %T %z")
  end
end
