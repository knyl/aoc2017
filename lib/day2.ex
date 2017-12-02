defmodule Day2 do

  def corruption_checksum_pt1(matrix) do
    matrix |> Enum.map(&Enum.min_max/1) |> Enum.map(&difference_min_max/1) |> Enum.sum
  end

  def corruption_checksum_pt2(matrix) do
    matrix |> Enum.map(&divide_divisible_numbers/1) |> Enum.sum
  end

  defp difference_min_max({min, max}) do
    max - min
  end

  defp divide_divisible_numbers([hd | list]) do
    do_divide_divisible_numbers(hd, list, list)
  end

  defp do_divide_divisible_numbers(n, [hd | _], _) when rem(hd, n) == 0, do: div(hd, n)
  defp do_divide_divisible_numbers(n, [hd | _], _) when rem(n, hd) == 0, do: div(n, hd)
  defp do_divide_divisible_numbers(_, [_ | []], [hd | tail]) do
    do_divide_divisible_numbers(hd, tail, tail)
  end
  defp do_divide_divisible_numbers(n, [_ | list], org_list) do
    do_divide_divisible_numbers(n, list, org_list)
  end
end
