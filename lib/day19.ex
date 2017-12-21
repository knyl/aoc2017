defmodule Day19 do

  def tubes_pt1(maze) do
    start = find_start(Enum.at(maze, 0))
    {res, _steps} = walk(maze, start, :south)
    Enum.join(res) |> String.trim()
  end

  def tubes_pt2(maze) do
    start = find_start(Enum.at(maze, 0))
    {_res, steps} = walk(maze, start, :south)
    steps
  end

  defp find_start(string) do
    # TODO: Doesn't work when start is at (0, 0)
    [l1, _l2] = String.split(string, "|")
    c1 = String.length(l1)
    {c1, 0}
  end

  defp walk(maze, pos, dir, res \\ [], steps \\ 0) do
    square = get_square(maze, pos)
    next_coord = next(maze, square, pos, dir)
    #IO.puts "next #{inspect(pos)} #{inspect(next_coord)} #{inspect(square)}"
    case next_coord do
      :end -> {Enum.reverse(res), steps}
      {coord, new_dir, char} ->
        walk(maze, coord, new_dir, [char | res], steps + 1)
      {coord, new_dir} -> walk(maze, coord, new_dir, res, steps + 1)
    end
  end

  defp next(_maze, " ", _, _), do: :end
  defp next(_maze, _, {-1, _y}, _), do: :end
  defp next(_maze, _, {_x, -1}, _), do: :end
  defp next(_maze, "|", {x, y}, :south), do: {{x, y + 1}, :south}
  defp next(_maze, "-", {x, y}, :south), do: {{x, y + 1}, :south}
  defp next(_maze, "|", {x, y}, :north), do: {{x, y - 1}, :north}
  defp next(_maze, "-", {x, y}, :north), do: {{x, y - 1}, :north}
  defp next(maze, "+", {x, y}, dir) when dir == :south or dir == :north do
    east_square = get_square(maze, {x+1, y})
    west_square = get_square(maze, {x-1, y})
    #IO.puts "west #{inspect(west_square)}"
    cond do
      east_square == nil && west_square == nil -> :end
      east_square != nil && east_square != " " -> {{x+1, y}, :east}
      west_square != nil && west_square != " " -> {{x-1, y}, :west}
      true -> :end
    end
  end
  defp next(_maze, char, {x, y}, :south), do: {{x, y+1}, :south, char}
  defp next(_maze, char, {x, y}, :north), do: {{x, y-1}, :north, char}
  defp next(_maze, "-", {x, y}, :east), do: {{x + 1, y}, :east}
  defp next(_maze, "|", {x, y}, :east), do: {{x + 1, y}, :east}
  defp next(_maze, "-", {x, y}, :west), do: {{x - 1, y}, :west}
  defp next(_maze, "|", {x, y}, :west), do: {{x - 1, y}, :west}
  defp next(maze, "+", {x, y}, dir) when dir == :east or dir == :west do
    north_square = get_square(maze, {x, y-1})
    south_square = get_square(maze, {x, y+1})
    #IO.puts "north #{inspect(north_square)} #{inspect(south_square)}"
    cond do
      north_square == nil && south_square == nil -> :end
      north_square != nil && north_square != " " -> {{x, y-1}, :north}
      south_square != nil && south_square != " " -> {{x, y+1}, :south}
      true -> :end
    end
  end
  defp next(_maze, char, {x, y}, :east), do: {{x+1, y}, :east, char}
  defp next(_maze, char, {x, y}, :west), do: {{x-1, y}, :west, char}

  defp get_square(_maze, {-1, _y}), do: nil
  defp get_square(_maze, {_x, -1}), do: nil
  defp get_square(maze, {x, y}) do
    if y >= length(maze) || y < 0 do
      nil
    else
      line = Enum.at(maze, y)
      if x < String.length(line) && x >= 0 do
        String.at(line, x)
      else
        nil
      end
    end
  end
end
