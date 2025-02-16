defmodule Venom.Cell do
  @moduledoc """
  A cell is the most basic building block of the game board. It can contain a snake, a fruit or nothing.
  """

  @type cell_state :: :snake | :fruit | :empty
  @type movement() :: :up | :down | :left | :right

  @spec next_state(cell_state(), movement()) :: cell_state
  def next_state(:fruit, :eat), do: :empty
  def next_state(:fruit, _), do: :fruit
  def next_state(:snake, _), do: :snake
end
