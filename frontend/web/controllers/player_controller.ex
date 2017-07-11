defmodule FrontTicTac.PlayerController do
  use FrontTicTac.Web, :controller

  def init(options) do
    options
  end

  def call(conn, _opts) do
    cond do
      player = conn.assigns[:current_player] ->
        assign(conn, :current_player, player)
      player = get_session(conn, :current_player) ->
        assign(conn, :current_player, player)
      true ->
        assign(conn, :current_player, nil)
    end

    redirect(conn, to: game_path(conn, :new))
  end

  def create(conn, params) do
    player = Map.get(params, "name", "player")

    conn
    |> assign(:current_player, player)
    |> put_session(:current_player, player)
    |> configure_session(renew: true)
    |> redirect(to: game_path(conn, :new))
  end
end
