defmodule FrontTicTac.GameChannel do
  use Phoenix.Channel

  def join("game:" <> name, _params, socket) do
    game = TicTacToe.Registry.game_process(name)

    case TicTacToe.Game.join(game, socket.assigns.player) do
      {:ok, symbol, game_state} ->
        send self(), {:after_join, game_state}
        socket =
          socket
          |> assign(:game, name)
          |> assign(:symbol, symbol)
        {:ok, game_state, socket}
      :error ->
        {:error, %{reason: "full game"}}
    end
  end

  def handle_in("put", %{"index" => index}, socket) do
    game = TicTacToe.Registry.game_process(socket.assigns.game)
    case TicTacToe.Game.put(game, socket.assigns.symbol, String.to_integer(index)) do
      {:ok, game_state} ->
        broadcast! socket, "update_board", game_state
      {:draw, game_state} ->
        broadcast! socket, "finish_game", game_state
      {:winner, _symbol, game_state} ->
        broadcast! socket, "finish_game", game_state
      _ ->
        :ok
    end
    {:noreply, socket}
  end

  def handle_info({:after_join, game_state}, socket) do
    broadcast! socket, "new_player", game_state
    {:noreply, socket}
  end
end
