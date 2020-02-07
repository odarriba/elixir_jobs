defmodule ElixirJobsWeb.LayoutView do
  use ElixirJobsWeb, :view

  import Phoenix.Controller, only: [current_url: 1]

  alias ElixirJobsWeb.MicrodataHelper
  alias ElixirJobsWeb.SeoHelper
end
