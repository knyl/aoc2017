defmodule Day5 do

  def twisty_trampolines_pt1(numbers) do
    map = numbers_into_map(%{}, numbers, 0)
    walk(map, 0, 0, length(numbers))
  end

  def twisty_trampolines_pt2(numbers) do
    map = numbers_into_map(%{}, numbers, 0)
    walk2(map, 0, 0, length(numbers))
  end

  defp numbers_into_map(map, [], _), do: map
  defp numbers_into_map(map, [hd | tail], i) do
    numbers_into_map(Map.put(map, i, hd), tail, i+1)
  end

  defp walk(_, position, steps, length) when position >= length, do: steps
  defp walk(map, position, steps, length) do
    current_offset = map[position]
    updated_map = Map.put(map, position, current_offset + 1)
    next_position = position + current_offset
    walk(updated_map, next_position, steps + 1, length)
  end

  defp walk2(_, position, steps, length) when position >= length or
                                              position < 0, do: steps
  defp walk2(map, position, steps, length) do
    current_offset = map[position]
    updated_offset =
      if current_offset > 2 do
        current_offset - 1
      else
        current_offset + 1
      end
    updated_map = Map.put(map, position, updated_offset)
    next_position = position + current_offset
    walk2(updated_map, next_position, steps + 1, length)
  end
end
