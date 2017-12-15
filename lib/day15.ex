defmodule Day15 do
  use Bitwise

  @mod_value 2147483647
  @factor_a 16807
  @factor_b 48271

  def dueling_generators_pt1(start_a, start_b) do
    length = 40000000
    values_a = generate_values(start_a, @factor_a, 1, length)
    values_b = generate_values(start_b, @factor_b, 1, length)
    count_matching(values_a, values_b)
  end

  def dueling_generators_pt2(start_a, start_b) do
    length = 5000000
    values_a = generate_values(start_a, @factor_a, 4, length)
    values_b = generate_values(start_b, @factor_b, 8, length)
    count_matching(values_a, values_b)
  end

  defp next(prev, factor), do: rem(prev * factor, @mod_value)

  defp matches?(a, b), do: lowest_16(a) === lowest_16(b)

  defp lowest_16(num), do: num &&& 0xffff

  defp generate_values(start, factor, mul, length) do
    Stream.iterate(start, &next(&1, factor))
    |> Stream.filter(fn (x) -> rem(x, mul) === 0 end)
    |> Enum.take(length)
  end

  defp count_matching(list_a, list_b, count \\ 0)
  defp count_matching([], [], count), do: count
  defp count_matching([a | rest_a], [b | rest_b], count) do
    if matches?(a, b) do
      count_matching(rest_a, rest_b, count + 1)
    else
      count_matching(rest_a, rest_b, count)
    end
  end

end
