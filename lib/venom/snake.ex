defmodule Venom.Snake do
  @moduledoc """
  The snake is the only thing that can move over the board.
  """

  @type snake_state :: :alive | :dead
  @type movement() :: :up | :down | :left | :right
  @type meet() :: :nothing | :wall | :fruit | :tail

  @spec next_state(snake_state(), movement(), meet()) :: snake_state
  def next_state(:alive, _, :snake), do: :dead
  def next_state(:alive, _, :wall), do: :dead
  def next_state(_, _, _), do: :alive
end
