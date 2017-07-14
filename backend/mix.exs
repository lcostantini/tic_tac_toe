defmodule TicTacToe.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tic_tac_toe,
      version: "0.1.0",
      elixir: "~> 1.5-rc",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :gproc],
      mod: {TicTacToe, []}
    ]
  end

  defp deps do
    [ {:gproc, "0.5.0"} ]
  end
end
