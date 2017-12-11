defmodule Day11 do

  def hex_ed_pt1(path) do
    coords = Enum.reduce(path, {0, 0}, &walk/2)
    distance(coords)
  end

  def hex_ed_pt2(path) do
    {_, _, max_distance} = Enum.reduce(path, {0, 0, 0}, &walk_and_save_dist/2)
    max_distance
  end

  defp walk("n", {x, y}), do: {x, y + 1}
  defp walk("nw", {x, y}), do: {x - 1, y + 1}
  defp walk("sw", {x, y}), do: {x - 1, y}
  defp walk("s", {x, y}), do: {x, y - 1}
  defp walk("se", {x, y}), do: {x + 1, y - 1}
  defp walk("ne", {x, y}), do: {x + 1, y}

  defp distance(coords, steps \\ 0)
  defp distance({0, 0}, steps), do: steps
  defp distance({0, y}, steps), do: steps + Kernel.abs(y)
  defp distance({x, 0}, steps), do: steps + Kernel.abs(x)
  defp distance({x, y}, steps) when y < 0 and x > 0 or y > 0 and x < 0 do
    x_closest = Kernel.abs(x) < Kernel.abs(y)
    if x_closest do
      distance({0, y + x}, steps + Kernel.abs(x))
    else
      distance({x + y, 0}, steps + Kernel.abs(y))
    end
  end
  defp distance({x, y}, steps) do
    steps + Kernel.abs(x) + Kernel.abs(y)
  end

  defp walk_and_save_dist(dir, {x, y, max_dist}) do
    {new_x, new_y} = walk(dir, {x, y})
    distance = distance({new_x, new_y})
    {new_x, new_y, Enum.max([max_dist, distance])}
  end
end
