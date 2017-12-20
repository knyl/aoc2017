defmodule Day20 do

  def particle_swarm_pt1(input) do
    {_, map} = Enum.reduce(input, {0, %{}}, &parse_line/2)
    {_, _, first_acc} = Map.get(map, 0)
    {_, pos} = Enum.reduce(map, {first_acc, 0}, &find_lowest_acc/2)
    pos
  end

  defp find_lowest_acc({key, {_, _, acc}}, {lowest_acc, i}) do
    if sum(acc) < sum(lowest_acc) do
      {acc, key}
    else
      {lowest_acc, i}
    end
  end

  defp parse_line(string, {i, map}) do
    ["p=<" <> pos_str, "v=<" <> vel_str, "a=<" <> acc_str] = String.split(string, ", ")
    pos = get_coord(pos_str)
    vel = get_coord(vel_str)
    acc = get_coord(acc_str)
    {i + 1, Map.put(map, i, {pos, vel, acc})}
  end

  defp get_coord(string) do
    str = String.replace(string, ">", "")
    [x, y, z] = String.split(str, ",")
    {String.to_integer(x), String.to_integer(y), String.to_integer(z)}
  end

  defp sum({x, y, z}) do
    abs(x) + abs(y) + abs(z)
  end

end
