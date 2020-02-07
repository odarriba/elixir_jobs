defmodule ElixirJobsWeb.ViewHelper do
  @moduledoc """
  Module with helpers commonly used in other views.
  """

  use PhoenixHtmlSanitizer, :markdown_html

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
    sanitize(text, :strip_tags)
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
