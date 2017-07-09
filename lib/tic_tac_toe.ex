defmodule TicTacToe do
  use Application

  def start(_type, _args) do
    TicTacToe.Supervisor.start_link()
  end
end
