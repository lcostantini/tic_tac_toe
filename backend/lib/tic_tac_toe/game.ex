defmodule TicTacToe.Game do
  @moduledoc """
  This is the Game Server.
  """

  use GenServer

  defstruct(board: %TicTacToe.Board{},
            x: nil,
            o: nil,
            first: :x,
            next: :x,
            finished: false,
            victories_x: 0,
            victories_o: 0
  )

  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, name: via_tuple(name))
  end

  @doc """
  Adds a new player to the game.
  """
  def join(game, player_pid) do
    GenServer.call(game, {:join, player_pid})
  end

  def put(game, value, position) do
    GenServer.call(game, {:put, value, position})
  end

  def new_round(game) do
    GenServer.call(game, :new_round)
  end

  def whereis(name) do
    :gproc.whereis_name({:n, :l, {:game, name}})
  end

  defp via_tuple(name) do
    {:via, :gproc, {:n, :l, {:game, name}}}
  end

  def init(_) do
    {:ok, %TicTacToe.Game{}}
  end

  def handle_call(:new_round, _from, state) do
    new_state =
      %{state | board: %TicTacToe.Board{}, finished: false}
      |> next_round()
    {:reply, new_state, new_state}
  end

  def handle_call({:join, player}, _from, state) do
    cond do
      is_nil(state.x) ->
        state = %{state | x: player}
        {:reply, {:ok, :x, state}, state}
      is_nil(state.o) ->
        state = %{state | o: player}
        {:reply, {:ok, :o, state}, state}
      true ->
        {:reply, :error, state}
    end
  end

  def handle_call({:put, _symbol, _pos}, _from, %{finished: true} = state) do
    {:reply, :finished, state}
  end

  def handle_call({:put, value, position}, _from, %{next: value} = state) do
    case TicTacToe.Board.put(state.board, position, value) do
      {:ok, board} ->
        state = %{state | board: board}
        cond do
          winner = TicTacToe.Board.winner(board) ->
            state =
              case winner do
                :x ->
                  %{state | finished: true, victories_x: state.victories_x + 1}
                :o ->
                  %{state | finished: true, victories_o: state.victories_o + 1}
              end
            {:reply, {:winner, winner, state}, state}
          TicTacToe.Board.full?(board) ->
            state = %{state | finished: true}
            {:reply, {:draw, state}, state}
          true ->
            state = next_turn(state)
            {:reply, {:ok, state}, state}
        end
      :error -> {:reply, :retry, state}
    end
  end

  def handle_call({:put, _symbol, _position}, _form, state) do
    {:reply, :cheat, state}
  end

  def handle_call(:restart_game, _from, state) do
    {:reply, {state.x, state.o}, state}
  end

  defp next_turn(%{next: :x} = state) do
    %{state | next: :o}
  end

  defp next_turn(%{next: :o} = state) do
    %{state | next: :x}
  end

  defp next_round(%{first: :x} = state) do
    %{state | first: :o, next: :o}
  end

  defp next_round(%{first: :o} = state) do
    %{state | first: :x, next: :x}
  end
end
