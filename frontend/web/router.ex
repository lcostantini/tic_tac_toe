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

    resources "/games", GameController, only: [:index, :create, :show], param: "name"
  end
end
