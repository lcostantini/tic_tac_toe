defmodule TicTacToe.Supervisor do
  @moduledoc """
  This is used to supervise the child processes for the Game and the Registry
  """

  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(TicTacToe.Registry, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
