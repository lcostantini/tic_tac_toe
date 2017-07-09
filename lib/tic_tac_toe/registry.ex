defmodule TicTacToe.Registry do
  @moduledoc """
  This module is used to associate a name with the PID process.
  """

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, %{}}
  end
end
