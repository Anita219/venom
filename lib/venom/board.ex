defmodule Venom.Board do
  @moduledoc """
  The game board on which the snake can move
  """

  alias Venom.Cell

  defstruct cells: [], width: 20, height: 20

  @type coordinate :: {integer(), integer()}
  @type cell_list :: list(Cell.cell_state())

  @type t :: %Venom.Board{cells: cell_list, height: integer(), width: integer()}

  def start(size \\ 20) do
    cells = empty_cells(size, size)
    %__MODULE__{width: size, height: size, cells: cells}
  end

  def next_state(board) do
    board
  end

  defp empty_cells(width, height) do
    1..(width * height)
    |> Enum.map(fn _ -> :empty end)
  end
end
