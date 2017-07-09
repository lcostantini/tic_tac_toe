defmodule TicTacToe.Game do
  @moduledoc """
  This is the Game Server.
  """

  use GenServer

  defstruct board: %TicTacToe.Board{}, player1: nil, player2: nil, waiting: :o

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  @doc """
  Adds a new player to the game.
  """
  def join(game, player_pid) do
    GenServer.call(game, {:join, player_pid})
  end

  def init(_) do
    {:ok, %TicTacToe.Game{}}
  end

  def handle_call({:join, player_pid}, _from, state) do
    cond do
      is_nil(state.player1) ->
        state = %{state | player1: player_pid}
        {:reply, {:ok, :x}, state}
      is_nil(state.player2) ->
        state = %{state | player2: player_pid}
        state = next_turn(state)
        {:reply, {:ok, :o}, state}
      true ->
        {:reply, :error, state}
    end
  end

  defp next_turn(%{waiting: :o, player1: player1, board: board} = state) do
    send player1, {:play, board}
    %{state | waiting: :x}
  end

  defp next_turn(%{waiting: :x, player2: player2, board: board} = state) do
    send player2, {:play, board}
    %{state | waiting: :o}
  end
end
