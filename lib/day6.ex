defmodule Day6 do

  def memory_reallocation_pt1(input) do
    map = Map.new(Stream.zip(0..length(input), input))
    {iterations, _} = cycle(map)
    iterations
  end

  def memory_reallocation_pt2(input) do
    map = Map.new(Stream.zip(0..length(input), input))
    {iterations, cycles} = cycle(map)
    iterations - cycles
  end


  defp cycle(input, iterations \\ 0, hashes \\ MapSet.new, cycles \\ %{}) do
    reallocation = reallocate(input)
    realloc_string = Map.values(reallocation) |> Enum.join
    if MapSet.member?(hashes, realloc_string) do
      {iterations + 1, cycles[realloc_string]}
    else
      updated_hashes = MapSet.put(hashes, realloc_string)
      updated_cycles = Map.put(cycles, realloc_string, iterations + 1)
      cycle(reallocation, iterations + 1, updated_hashes, updated_cycles)
    end
  end

  defp reallocate(input) do
    {i, max} = Enum.max_by(input, fn ({_, x}) -> x end)
    length = map_size(input)
    position = next_pos(i, length)
    do_reallocate(Map.put(input, i, 0), position, max, length)
  end

  defp do_reallocate(input, _, 0, _), do: input
  defp do_reallocate(input, pos, value, length) do
    prev_value = Map.get(input, pos)
    do_reallocate(Map.put(input, pos, prev_value + 1), next_pos(pos, length), value - 1, length)
  end

  defp next_pos(pos, length) do
    Integer.mod(pos + 1, length)
  end
end
