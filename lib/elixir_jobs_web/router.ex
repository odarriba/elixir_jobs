defmodule ElixirJobsWeb.Router do
  use ElixirJobsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug ElixirJobsWeb.Plugs.GuardianPipeline
  end

  pipeline :authentication_required do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirJobsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", OfferController, :index
    get "/rss", OfferController, :rss
    get "/page/:page_number", OfferController, :index, as: :offer_page
    get "/offers/new", OfferController, :new
    post "/offers/new", OfferController, :create
    get "/offers/:slug", OfferController, :show

    get "/login", AuthController, :new
    post "/login", AuthController, :create
  end

  scope "/", ElixirJobsWeb do
    pipe_through [:browser, :authentication_required] # Use the default browser stack

    get "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirJobsWeb do
  #   pipe_through :api
  # end
end
