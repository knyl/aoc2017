defmodule Day3 do
  require Integer

  @doc """
  Given a number, return the manhattan distance to the center (1) of
  a square like this:

  5 4 3 12
  6 1 2 11
  7 8 9 10

  The distance for 12 is 3, the distance for 8 is 1

  Calculates the manhattan distance by first finding the distance from the
  spiral round the number is on, in to the center. Then finding the closest
  middle point of a side of the spiral round, and calculating the distance
  to that middle point.
  """
  def spiral_memory_pt1(1), do: 0
  def spiral_memory_pt1(number) do
    lower_sqrt = trunc(:math.sqrt(number))
    side_length = get_side_length(lower_sqrt, number)

    steps_to_core = div((side_length - 1), 2)
    steps_to_side_middle = calculate_steps_to_side_middle(number, side_length)
    steps_to_core + steps_to_side_middle
  end

  defp get_side_length(sqrt, _) when Integer.is_even(sqrt), do: sqrt + 1
  defp get_side_length(sqrt, number) when sqrt*sqrt == number, do: sqrt
  defp get_side_length(sqrt, _), do: sqrt + 2

  defp calculate_steps_to_side_middle(number, side_length) do
    upper_sqrt_corner = side_length * side_length
    corners = get_corners(upper_sqrt_corner, side_length - 1)
    {closest_distance, _corner} = find_closest_corner(number, corners)
    closest_distance
  end

  defp get_corners(sqrt_corner, side_length) do
    distance_to_middle = div(side_length, 2)
    0..3 |> Enum.map(fn (x) -> sqrt_corner - distance_to_middle - x * side_length end)
  end

  defp find_closest_corner(number, corners) do
    corners |> Enum.map(fn (x) -> {abs(x - number), x} end) |> Enum.min
  end

  @doc """
  Given a number, return the next number which is bigger than the current number
  a square like this:

  5 4 3 12
  6 1 2 11
  7 8 9 10

  The distance for 12 is 3, the distance for 8 is 1
  """
  def spiral_memory_pt2(number) do
    map = %{{0, 0} => 1}
    start_spiral_walk(map, {0, 0}, 2, number)
  end

  defp start_spiral_walk(map, prev_step, steps, number) do
    {new_map, new_step, value} =
      {map, prev_step, 1} |> walk(1, {1, 0}, number)
                          |> walk(steps-1, {0, 1}, number)
                          |> walk(steps, {-1, 0}, number)
                          |> walk(steps, {0, -1}, number)
                          |> walk(steps, {1, 0}, number)

    if value > number do
      value
    else
      start_spiral_walk(new_map, new_step, steps + 2, number)
    end
  end

  #  Walks along one side of the spiral
  #
  #  ## Parameters
  #  - map: A map storing values given a coordinate as key
  #  - step: The coordinates of the point we just left
  #  - last_number: The value of the point we just left, stored so that the
  #      stop-clause can be reached.
  #  - steps: The number of steps left to take in this direction
  #  - direction: The direction (and step-length)
  #  - number: The number we are looking for
  defp walk({map, step, last_number}, 0, _, _), do: {map, step, last_number}
  defp walk({map, step, last_number}, _, _, number) when last_number > number do
    {map, step, last_number}
  end
  defp walk({map, previous_step, _}, steps, direction, number) do
    new_step = take_step(previous_step, direction)
    new_value = get_values(map, new_step)
    new_map = Map.put(map, new_step, new_value)
    result = {new_map, new_step, new_value}
    walk(result, steps - 1, direction, number)
  end

  defp take_step({prev_x, prev_y}, {dir_x, dir_y}) do
    {prev_x + dir_x, prev_y + dir_y}
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
