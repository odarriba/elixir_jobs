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
    get "/about", PageController, :about
    get "/rss", OfferController, :rss
    get "/sitemap.xml", SitemapController, :sitemap
    get "/page/:page", OfferController, :index, as: :offer_page
    get "/search", OfferController, :search
    get "/offers/place/:filter", OfferController, :index_place
    get "/offers/type/:filter", OfferController, :index_type
    get "/offers/new", OfferController, :new
    post "/offers/new", OfferController, :create
    post "/offers/preview", OfferController, :preview
    put "/offers/preview", OfferController, :preview
    get "/offers/:slug", OfferController, :show

    get "/login", AuthController, :new
    post "/login", AuthController, :create
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

  scope "/", ElixirJobsWeb do
    pipe_through [:browser, :authentication_required] # Use the default browser stack

    get "/logout", AuthController, :delete

    scope "/admin", Admin, as: :admin do
      get "/offers/published", OfferController, :index_published
      get "/offers/pending", OfferController, :index_unpublished
      get "/offers/:slug/publish", OfferController, :publish
      get "/offers/:slug/unpublish", OfferController, :unpublish
      get "/offers/:slug/edit", OfferController, :edit
      put "/offers/:slug/edit", OfferController, :update
      delete "/offers/:slug", OfferController, :delete
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirJobsWeb do
  #   pipe_through :api
  # end
end
