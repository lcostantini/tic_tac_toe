defmodule TicTacToe.Board do
  @moduledoc """
  This is the module to control the actions on the board.
  """

  defstruct data: { nil, nil, nil, nil, nil, nil, nil, nil, nil }

  @values [:x, :o]

  @doc """
  Insert a value into the board.
  """
  def put(board, position, value) when value in @values do
    case get(board.data, position) do
      nil ->
        data = put_elem(board.data, position, value)
        {:ok, %TicTacToe.Board{data: data}}
      {:error, message} -> {:error, message}
    end
  end

  @doc """
  If the value to insert into the board is invalid send an error.
  """
  def put(_, _, _), do: :error

  @doc """
  Find a value on the board or send an error.
  """
  def get(data, position) do
    try do
      elem(data, position)
    rescue
      ArgumentError -> {:error, 'The position is invalid'}
    end
  end

  @doc """
  Check if the board is full with values.
  """
  def full?(%TicTacToe.Board{data: data}) do
    !(nil in Tuple.to_list(data))
  end

  @doc """
  Check if a player wins the game.
  """
  def winner(%TicTacToe.Board{data: data}) do
    player_winner(data)
  end

  defp player_winner({v, v, v,
                      _, _, _,
                      _, _, _}) when v in @values, do: v

  defp player_winner({_, _, _,
                      v, v, v,
                      _, _, _}) when v in @values, do: v

  defp player_winner({_, _, _,
                      _, _, _,
                      v, v, v}) when v in @values, do: v

  defp player_winner({v, _, _,
                      v, _, _,
                      v, _, _}) when v in @values, do: v

  defp player_winner({_, v, _,
                      _, v, _,
                      _, v, _}) when v in @values, do: v

  defp player_winner({_, _, v,
                      _, _, v,
                      _, _, v}) when v in @values, do: v

  defp player_winner({v, _, _,
                      _, v, _,
                      _, _, v}) when v in @values, do: v

  defp player_winner({_, _, v,
                      _, v, _,
                      v, _, _}) when v in @values, do: v

  defp player_winner(_), do: nil
end
