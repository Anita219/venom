defmodule VenomWeb.BoardLive do
  @moduledoc """
  Presentation Layer for Snake
  """

  use Phoenix.LiveView

  alias Venom.Board

  @empty "⬜️"

  def render(assigns) do
    ~H"""
    <div class="board-container">
      <div class="board">
        <%= for _y <- 0..20 do %>
          <div class="row">
            <%= for _x <- 0..20 do %>
              <div class="cell">{"empty"}</div>
            <% end %>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    speed = 1000
    Process.send_after(self(), :tick, speed)

    board = Board.start()

    socket = socket |> assign(:board, board) |> assign(:speed, speed)

    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    %{assigns: %{speed: speed, board: board}} = socket
    board = Board.next_state(board)

    Process.send_after(self(), :tick, speed)

    {:noreply, assign(socket, :board, board)}
  end

  def handle_event("reset", _form_data, socket) do
    %{assigns: %{board: %{width: size}}} = socket
    new_board = Board.start(size)

    socket =
      socket
      |> assign(:board, new_board)

    {:noreply, socket}
  end

  def handle_event("update_settings", form_data, socket) do
    %{"board_size" => size, "speed" => speed} = form_data
    %{assigns: %{board: %{width: width} = board}} = socket
    size = String.to_integer(size)

    board =
      if width != size do
        Board.start(size)
      else
        board
      end

    socket =
      socket
      |> assign(:board, board)
      |> assign(:speed, String.to_integer(speed))

    {:noreply, socket}
  end

  defp display_cell(:empty), do: @empty
end
