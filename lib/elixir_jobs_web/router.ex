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
    # Use the default browser stack
    pipe_through :browser

    get "/", OfferController, :index
    get "/about", PageController, :about
    get "/sponsors", PageController, :sponsors
    get "/rss", OfferController, :rss
    get "/sitemap.xml", SitemapController, :sitemap
    get "/page/:page", OfferController, :index, as: :offer_page
    get "/search", OfferController, :search
    get "/offers/filter/:filter", OfferController, :index_filtered
    get "/offers/place/:filter", OfferController, :index_filtered
    get "/offers/new", OfferController, :new
    post "/offers/new", OfferController, :create
    post "/offers/preview", OfferController, :preview
    put "/offers/preview", OfferController, :preview
    get "/offers/:slug", OfferController, :show

    get "/login", AuthController, :new
    post "/login", AuthController, :create
  end

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  scope "/", ElixirJobsWeb do
    # Use the default browser stack
    pipe_through [:browser, :authentication_required]

    get "/logout", AuthController, :delete

    scope "/admin", Admin, as: :admin do
      get "/offers/published", OfferController, :index_published
      get "/offers/pending", OfferController, :index_unpublished
      get "/offers/:slug/publish", OfferController, :publish
      get "/offers/:slug/send_twitter", OfferController, :send_twitter
      get "/offers/:slug/send_telegram", OfferController, :send_telegram
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
