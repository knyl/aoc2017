defmodule Day2 do

  def corruption_checksum_pt1(matrix) do
    matrix |> Enum.map(&get_max_and_min/1) |> Enum.map(&difference_min_max/1) |> Enum.sum
  end

  defp get_max_and_min(list) do
    Enum.min_max(list)
  end


  defp difference_min_max({min, max}) do
    max - min
  end
end
