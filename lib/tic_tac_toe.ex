defmodule TicTacToe do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(TicTacToe.GameSupervisor, []),
      worker(TicTacToe.Registry, [])
    ]

    Supervisor.start_link(children, strategy: :rest_for_one, name: TicTacToe.Supervisor)
  end
end
