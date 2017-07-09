defmodule TicTacToe.Game do
  @moduledoc """
  This is the Game Server.
  """

  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end
end
