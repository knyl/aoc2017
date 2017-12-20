defmodule Day20 do

  def particle_swarm_pt1(input) do
    {_, map} = Enum.reduce(input, {0, %{}}, &parse_line/2)
    {_, _, first_acc} = Map.get(map, 0)
    {_, pos} = Enum.reduce(map, {first_acc, 0}, &find_lowest_acc/2)
    pos
  end

  def particle_swarm_pt2(input) do
    {_, map} = Enum.reduce(input, {0, %{}}, &parse_line/2)
    move(map)
  end

  defp move(map, step \\ 0)
  defp move(map, 1000), do: length(Map.keys(map))
  defp move(map, step) do
    updated_points = move_points(map)
    move(updated_points, step + 1)
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

  defp move_points(map) do
    updated_map = Enum.reduce(map, %{}, &update_points/2)
    colliding = find_colliding(updated_map)
    remove_colliding(updated_map, colliding)
  end

  defp update_points({key, {pos, vel, acc}}, map) do
    {px, py, pz} = pos
    {vx, vy, vz} = vel
    {ax, ay, az} = acc
    {nvx, nvy, nvz} = new_vel = {vx + ax, vy + ay, vz + az}
    new_pos = {nvx + px, nvy + py, nvz + pz}
    Map.put(map, key, {new_pos, new_vel, acc})
  end

  defp find_colliding(map) do
    collision_map = Enum.reduce(map, %{}, &hash_on_pos/2)
    Enum.reduce(Map.values(collision_map), [], &get_colliding/2)
  end

  defp hash_on_pos({key, {pos, _, _}}, map) do
    keys = Map.get(map, pos, [])
    Map.put(map, pos, [key | keys])
  end

  defp get_colliding([_], list), do: list
  defp get_colliding(elems, list), do: elems ++ list

  defp remove_colliding(map, colliding) do
    Enum.reduce(colliding, map, &do_remove/2)
  end

  defp do_remove(elem, map) do
    Map.delete(map, elem)
  end

end
