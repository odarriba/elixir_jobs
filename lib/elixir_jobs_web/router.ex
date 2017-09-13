defmodule ElixirJobsWeb.Router do
  use ElixirJobsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirJobsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", OfferController, :index
    get "/rss", OfferController, :rss
    get "/page/:page_number", OfferController, :index
    get "/offers/new", OfferController, :new
    post "/offers/new", OfferController, :create
    get "/offers/:slug", OfferController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirJobsWeb do
  #   pipe_through :api
  # end
end
