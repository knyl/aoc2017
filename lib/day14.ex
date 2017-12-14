defmodule Day14 do

  def disk_defragmentation_pt1(input) do
    binary_hashes = get_binary_hashes(input)

    Enum.sum(Enum.map(binary_hashes, &count_bits/1))
  end

  def disk_defragmentation_pt2(input) do
    binary_hashes = get_binary_hashes(input)
    map = hashes_to_map(binary_hashes)
  end

  defp get_binary_hashes(input) do
    Range.new(0, 127)
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

  defp hashes_to_map(binary) do
  end
end
