defmodule Day15 do
  use Bitwise

  def dueling_generators_pt1(start_a, start_b) do
    {_, _, c} = Enum.reduce(0..40000000, {start_a, start_b, 0}, &count_matching/2)
    c
  end

  def dueling_generators_pt2(start_a, start_b) do
    values_a = generate_values(start_a, 16807, 4)
    values_b = generate_values(start_b, 48271, 8)
    count_matching2(values_a, values_b)
  end

  defp count_matching(_, {a, b, count}) do
    next_a = next(a, 16807)
    next_b = next(b, 48271)
    if matches?(a, b) do
      IO.puts "#{inspect(a)} #{inspect(b)}"
      {next_a, next_b, count + 1}
    else
      {next_a, next_b, count}
    end
  end

  defp next(prev, factor), do: rem(prev * factor, 2147483647)

  defp matches?(a, b), do: lowest_16(a) == lowest_16(b)

  defp lowest_16(num) do
    band(num, String.to_integer("FFFF", 16))
         #<<_::16, l::16>> = <<num::32>>
         #l
  end

  defp generate_values(start, factor, mul) do
    Stream.iterate(start, &next(&1, factor))
    |> Stream.filter(fn (x) -> rem(x, mul) == 0 end)
    |> Enum.take(5000000)
  end

  defp count_matching2(list_a, list_b, count \\ 0)
  defp count_matching2([], [], count), do: count
  defp count_matching2([a | rest_a], [b | rest_b], count) do
    if matches?(a, b) do
      count_matching2(rest_a, rest_b, count + 1)
    else
      count_matching2(rest_a, rest_b, count)
    end
  end

end
