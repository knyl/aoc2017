defmodule Day12 do

  def digital_plumber_pt1(input) do
    pipes = Enum.reduce(input, %{}, &parse_groups/2)
  end

  defp parse_groups([p, rest], map) do
    connected_zero = Map.get(map, "0", [])
    string = String.split(rest, ",", trim: true) |> Enum.map(&String.trim/1)
  end
end
