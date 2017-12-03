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

end
