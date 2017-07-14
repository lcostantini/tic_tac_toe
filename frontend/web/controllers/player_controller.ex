defmodule FrontTicTac.PlayerController do
  use FrontTicTac.Web, :controller

  def init(options) do
    options
  end

  def call(conn, _opts) do
    conn
    |> put_session(:current_player, "Anonymous")
    |> redirect(to: "/games/new")
  end
end
