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

  defp distance({x, y}), do: Kernel.abs(x) + Kernel.abs(y)

  defp walk_and_save_dist(dir, {x, y, max_dist}) do
    {new_x, new_y} = walk(dir, {x, y})
    distance = distance({new_x, new_y})
    {new_x, new_y, Enum.max([max_dist, distance])}
  end
end
