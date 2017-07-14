defmodule TicTacToe.Board do
  @moduledoc """
  This is the module to control the actions on the board.
  """

  defstruct data: [ nil, nil, nil, nil, nil, nil, nil, nil, nil ]

  @values [:x, :o]

  @doc """
  Insert a value into the board.
  """
  def put(board, position, value) when value in @values do
    case Enum.at(board.data, position, :error) do
      nil ->
        data = List.replace_at(board.data, position, value)
        {:ok, %TicTacToe.Board{board | data: data}}
      :error -> :error
    end
  end

  @doc """
  If the value to insert into the board is invalid send an error.
  """
  def put(_, _, _), do: :error

  @doc """
  Check if the board is full with values.
  """
  def full?(%TicTacToe.Board{data: data}) do
    !(nil in data)
  end

  @doc """
  Check if a player wins the game.
  """
  def winner(%TicTacToe.Board{data: data}) do
    player_winner(data)
  end

  defp player_winner([v, v, v,
                      _, _, _,
                      _, _, _]) when v in @values, do: v

  defp player_winner([_, _, _,
                      v, v, v,
                      _, _, _]) when v in @values, do: v

  defp player_winner([_, _, _,
                      _, _, _,
                      v, v, v]) when v in @values, do: v

  defp player_winner([v, _, _,
                      v, _, _,
                      v, _, _]) when v in @values, do: v

  defp player_winner([_, v, _,
                      _, v, _,
                      _, v, _]) when v in @values, do: v

  defp player_winner([_, _, v,
                      _, _, v,
                      _, _, v]) when v in @values, do: v

  defp player_winner([v, _, _,
                      _, v, _,
                      _, _, v]) when v in @values, do: v

  defp player_winner([_, _, v,
                      _, v, _,
                      v, _, _]) when v in @values, do: v

  defp player_winner(_), do: nil
end
