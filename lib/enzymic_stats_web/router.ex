defmodule EnzymicStatsWeb.Router do
  use EnzymicStatsWeb, :router

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

  scope "/", EnzymicStatsWeb do
    pipe_through :api

    resources "/events", EventController, only: [:create]
    resources "/ad_unit_events", AdUnitEventController, only: [:create]
    resources "/ast_events", SmartTagEventController, only: [:create]
    get "/campaigns", CampaignController, :stats
    get "/ads", AdController, :stats
    get "/ad_units", AdUnitController, :stats
    get "/stats_by_ad_units", AdUnitController, :stats_by_ad_units
    post "/ad_units", AdUnitController, :create
    post "/events/unlike", EventController, :unlike
  end

  scope "/", EnzymicStatsWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", EnzymicStatsWeb do
  #   pipe_through :api
  # end
end
