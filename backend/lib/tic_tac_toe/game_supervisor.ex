defmodule TicTacToe.GameSupervisor do
  @moduledoc """
  This is used to supervise the child processes for the Game and the Registry
  """

  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def start_game(name) do
    Supervisor.start_child(__MODULE__, name)
  end

  def init(:ok) do
    children = [worker(TicTacToe.Game, [], restart: :temporary)]
    supervise(children, strategy: :simple_one_for_one)
  end
end
