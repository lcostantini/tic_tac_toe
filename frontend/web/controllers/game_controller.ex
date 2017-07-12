defmodule FrontTicTac.GameController do
  use FrontTicTac.Web, :controller

  def create(conn, params) do
    value = params["game"] || params

    case Map.get(value, "name") do
      nil ->
        conn
        |> put_flash(:error, "Game name cannot be empty")
        |> redirect(to: game_path(conn, :new))
      "" ->
        conn
        |> put_flash(:error, "Game name cannot be empty")
        |> redirect(to: game_path(conn, :new))
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
