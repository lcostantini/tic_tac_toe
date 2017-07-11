defmodule TacTacToe.BoardTest do
   use ExUnit.Case, async: true

   setup do
     board = %TicTacToe.Board{} |> TicTacToe.Board.put(0, :x) |> elem(1)
     {:ok, board: board}
   end

   test 'try to load a value in a valid board position', %{board: board} do
     assert elem(board.data, 0) == :x
   end

   test 'try to load a value in an invalid board position', %{board: board} do
     assert TicTacToe.Board.put(board, 10, :x) == {:error, 'The position is invalid'}
   end

   test 'try to load an invalid value in a valid board position', %{board: board} do
     assert TicTacToe.Board.put(board, 1, :z) == :error
   end

   test 'try to load an invalid value in an invalid board position', %{board: board} do
     assert TicTacToe.Board.put(board, 10, :z) == :error
   end

   test 'try to get a value for a valid board position', %{board: board} do
     assert TicTacToe.Board.get(board, 0) == :x
   end

   test 'try to get a value for an invalid board position', %{board: board} do
     assert TicTacToe.Board.get(board, 10) == {:error, 'The position is invalid'}
   end

   test 'the board is complete' do
     board = %TicTacToe.Board{data: {:x, :o, :x, :x, :x, :x, :o, :o, :o}}
     assert TicTacToe.Board.full?(board) == true
   end

   test 'the board is not complete yet' do
     board = %TicTacToe.Board{data: {:x, :o, :x, :x, nil, :x, :o, :o, :o}}
     assert TicTacToe.Board.full?(board) == false
   end

   test 'try to find a winner' do
     board = %TicTacToe.Board{data: {:x, nil, nil, :x, nil, nil, :x, nil, nil}}
     assert TicTacToe.Board.winner(board) == :x
   end

   test 'there is not winner yet' do
     board = %TicTacToe.Board{data: {:x, nil, nil, nil, :x, nil, :x, nil, nil}}
     assert TicTacToe.Board.winner(board) == nil
   end
end
