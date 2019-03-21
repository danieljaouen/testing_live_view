defmodule TestingLiveViewWeb.Router do
  use TestingLiveViewWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {TestingLiveViewWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TestingLiveViewWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/users/new", UserLive.New
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestingLiveViewWeb do
  #   pipe_through :api
  # end
end
