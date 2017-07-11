defmodule FrontTicTac.GameController do
  use FrontTicTac.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, params) do
    case Map.get(params, "name") do
      nil ->
        conn
        |> put_flash(:error, "Game name cannot be empty")
        |> render("index.html")
      name ->
        conn
        |> redirect(to: game_path(conn, :show, name))
    end
  end

  def show(conn, %{"name" => name}) do
    render conn, "show.html", name: name
  end

  def new(conn, _params) do
    render conn, "new.html"
  end
end
