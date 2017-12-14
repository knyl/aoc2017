defmodule Day14 do

  def disk_defragmentation_pt1(input) do
    binary_hashes = get_binary_hashes(input)

    Enum.sum(Enum.map(binary_hashes, &count_bits/1))
  end

  def disk_defragmentation_pt2(input) do
    binary_hashes = get_binary_hashes(input)
    map = hashes_to_map(binary_hashes)
    coords = List.flatten(generate_coords())
    walk(map, coords)
  end

  defp get_binary_hashes(input) do
    0..127
    |> Enum.map(&create_string(input, &1))
    |> Enum.map(&Day10.knot_hash_pt2/1)
    |> Enum.map(&to_binary/1)
  end

  defp create_string(string, i), do: string <> "-" <> Integer.to_string(i)

  defp to_binary(hex) do
    Base.decode16!(hex, case: :lower)
  end

  defp count_bits(string, count \\ 0)
  defp count_bits(<<>>, count), do: count
  defp count_bits(<<i::size(1), rest::bitstring>>, count) do
    count_bits(rest, count + i)
  end

  defp hashes_to_map(hashes) do
    maps = Enum.map(hashes, &binary_to_map/1)
    to_map(maps)
  end

  defp to_map(hashes) do
    hashes
    |> Stream.with_index
    |> Enum.reduce(%{}, fn ({hash, i}, map) -> Map.put(map, i, hash) end)
  end

  defp binary_to_map(hashes, map \\ %{}, i \\ 0)
  defp binary_to_map(<<>>, map, _), do: map
  defp binary_to_map(<<x::size(1), rest::bitstring>>, map, i), do: binary_to_map(rest, Map.put(map, i, x), i+1)

  defp generate_coords() do
    0..127 |> Enum.map(fn (x) -> Enum.map(0..127, fn (y) -> {x, y} end) end)
  end

  defp walk(map, coords, groups \\2)
  defp walk(_, [], groups), do: groups - 2
  defp walk(map, [{x, y} | coords], next_group) do
    if map[x][y] == 1 do
      updated_map = put_in(map[x][y], next_group)
      more_coords = get_coords({x, y})
      map_with_group = discover_group(updated_map, more_coords, next_group, MapSet.new([{x, y}]))
      walk(map_with_group, coords, next_group + 1)
    else
      walk(map, coords, next_group)
    end
  end

  defp discover_group(map, [], _, _), do: map
  defp discover_group(map, [coord | coords], group, visited) do
    {x, y} = coord
    if map[x][y] == 1 do
      if MapSet.member?(visited, coord) do
        discover_group(map, coords, group, visited)
      else
        updated_map = put_in(map[x][y], group)
        more_coords = get_coords(coord)
        discover_group(updated_map, coords ++ more_coords, group, MapSet.put(visited, coord))
      end
    else
      discover_group(map, coords, group, visited)
    end
  end

  defp get_coords({127, 127}), do: []
  defp get_coords({127, 0}), do: [{127, 1}, {126, 0}]
  defp get_coords({0, 127}), do: [{1, 127}, {0, 126}]
  defp get_coords({0, 0}), do: [{1, 0}, {0, 1}]
  defp get_coords({127, y}), do: [{127, y-1}, {127, y+1}, {126, y}]
  defp get_coords({x, 127}), do: [{x-1, 127}, {x+1, 127}, {x, 126}]
  defp get_coords({0, y}), do: [{0, y-1}, {0, y+1}, {1, y}]
  defp get_coords({x, 0}), do: [{x-1, 0}, {x+1, 0}, {x, 1}]
  defp get_coords({x, y}), do: [{x, y-1}, {x, y+1}, {x-1, y}, {x+1, y}]
end
