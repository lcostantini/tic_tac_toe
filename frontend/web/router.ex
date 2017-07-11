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

    get "/", PageController, :index

    resources "/games", GameController, only: [:create, :show, :new], param: "name"

    post "/players", PlayerController, param: "name"
  end
end
