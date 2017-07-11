defmodule TicTacToe.Registry do
  @moduledoc """
  This module is used to associate a name with the PID process.
  """

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def game_process(name) do
    case Process.whereis(name) do
      :undefined -> GenServer.call(__MODULE__, {:game_process, name})
      pid -> pid
    end
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:game_process, name}, _form, state) do
    game_pid = TicTacToe.GameSupervisor.start_game(name) |> elem(1)
    {:reply, game_pid, state}
  end
end
