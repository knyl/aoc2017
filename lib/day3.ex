defmodule Day3 do
  require Integer

  def spiral_memory_pt1(number) when number == 1, do: 0
  def spiral_memory_pt1(number) do
    lower_sqrt = trunc(:math.sqrt(number))
    side_length =
      if Integer.is_even(lower_sqrt) do
        lower_sqrt + 1
      else
        lower_sqrt + 2
      end
    
    steps_to_core = div((side_length - 1), 2)
    steps_to_side_middle = calculate_steps_to_side_middle(number, side_length)
    steps_to_core + steps_to_side_middle
  end

  def spiral_memory_pt2(number) do
    map = %{{0, 0} => 1}
    start_spiral_walk(map, {0, 0}, 2, number)
  end

  defp calculate_steps_to_side_middle(number, side_length) when number == (side_length * side_length) do
    div(side_length - 1, 2)
  end
  defp calculate_steps_to_side_middle(number, side_length) do
    upper_sqrt_corner = side_length * side_length
    corners = get_corners(upper_sqrt_corner, side_length - 1)
    {closest_distance, corner} = find_closest_corner(number, corners)
    closest_distance
  end

  defp get_corners(sqrt_corner, side_distance) do
    distance_to_middle = div(side_distance, 2)
    0..3 |> Enum.map(fn (x) -> sqrt_corner - distance_to_middle - x * side_distance end)
  end

  defp find_closest_corner(number, corners) do
    corners |> Enum.map(fn (x) -> {abs(x - number), x} end) |> Enum.min
  end

  defp start_spiral_walk(map, prev_step, steps, number) do
    {new_map, new_step} = 
      {map, prev_step} |> walk(1, {1, 0})
                       |> walk(steps, {0, 1})
                       |> walk(steps, {-1, 0})
                       |> walk(steps, {0, -1})
                       |> walk(steps, {1, 0})

    if new_map[new_step] > number do
      {new_map, new_step}
    else
      start_spiral_walk(new_map, new_step, steps + 2, number)
    end
  end

  defp walk({map, step}, 0, _), do: {map, step}
  defp walk({map, {prev_x, prev_y}}, side, {dir_x, dir_y}) do
    IO.puts "prev step: #{inspect(prev_x, prev_y)}"
    new_step = {prev_x + dir_x, prev_y + dir_y}
    new_value = get_values(map, new_step)
    res = {Map.put(map, new_step, new_value), new_step}
    IO.puts "After step {dir_x, dir_y} %{inspect({dir_x, dir_y})}: #{inspect(res)}"
    res

  end

  defp get_values(map, {x, y}) do
    Map.get(map, {x-1, y}, 0) +
      Map.get(map, {x-1, y + 1}, 0) +
      Map.get(map, {x-1, y - 1}, 0) +
      Map.get(map, {x, y - 1}, 0) +
      Map.get(map, {x, y + 1}, 0) +
      Map.get(map, {x + 1, y - 1}, 0) +
      Map.get(map, {x + 1, y + 1}, 0) +
      Map.get(map, {x + 1, y}, 0)
  end
    

end
