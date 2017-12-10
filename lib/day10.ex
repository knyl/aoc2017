defmodule Day10 do
  use Bitwise, only_operators: true

  def knot_hash_pt1(lengths, list) do
    numbers = to_map(Enum.to_list(list))
    {map, _, _} = cycle(lengths, numbers)
    map[0] * map[1]
  end

  def knot_hash_pt2(string) do
    lengths = string_to_ascii(string) ++ [17, 31, 73, 47, 23]
    numbers = to_map(Enum.to_list(0..255))
    sparse_hash = calculate_sparse_hash(lengths, numbers)
    sparse_hash |> xor
                |> Enum.map(&Integer.to_string(&1, 16))
                |> Enum.map(&String.pad_leading(&1, 2, "0"))
                |> Enum.join
                |> String.downcase
  end

  defp to_map(list, map \\ %{})
  defp to_map([], map), do: map
  defp to_map([h | tail], map) do
    updated_map = Map.put(map, h, h)
    to_map(tail, updated_map)
  end

  defp cycle(lengths, numbers, offset \\ 0, curr_pos \\ 0)
  defp cycle([], numbers, offset, curr_pos), do: {numbers, offset, curr_pos}
  defp cycle([len | tail], numbers, offset, curr_pos) do
    list_length = length(Enum.to_list(numbers))
    positions = Enum.to_list(0..(list_length - 1))
    slice_end = curr_pos + len - 1
    sub_positions = Enum.slice(positions++positions, curr_pos..slice_end)
    reversed_positions = Enum.reverse(sub_positions)
    updated_numbers = update_numbers(numbers, sub_positions, reversed_positions, numbers)
    new_curr_pos = rem(curr_pos + len + offset, list_length)
    cycle(tail, updated_numbers, offset + 1, new_curr_pos)
  end

  defp update_numbers(_, [], [], updated), do: updated
  defp update_numbers(original, [p1 | t1], [p2 | t2], updated) do
    update_numbers(original, t1, t2, %{updated | p1 => original[p2]})
  end

  defp calculate_sparse_hash(lengths, numbers) do
    {map, _, _} = Enum.reduce(1..64, {numbers, 0, 0}, &do_reduce(&1, &2, lengths))
    map_to_list(map)
  end

  defp string_to_ascii(string, numbers \\ [])
  defp string_to_ascii(<<>>, numbers), do: Enum.reverse(numbers)
  defp string_to_ascii(<<n>> <> rest, numbers), do: string_to_ascii(rest, [n | numbers])

  defp do_reduce(_, {numbers, offset, curr_pos}, lengths) do
    cycle(lengths, numbers, offset, curr_pos)
  end

  defp map_to_list(map) do
    Map.to_list(map) |> Enum.sort |> Enum.map(fn ({_, x}) -> x end)
  end

  defp xor(list, res \\ [])
  defp xor([], res), do: Enum.reverse(res)
  defp xor(list, res) do
    xor = list |> Enum.take(16)
               |> Enum.reduce(0, fn (x, acc) -> x ^^^ acc end)
    xor(Enum.slice(list, 16..-1), [xor | res])
  end

end
