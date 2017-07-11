defmodule FrontTicTac.Router do
  use FrontTicTac.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", FrontTicTac do
    pipe_through :browser

    get "/games", GameController, :index
  end
end
