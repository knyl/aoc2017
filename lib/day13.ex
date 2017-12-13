defmodule Day13 do

  def packet_scanners_pt1(input) do
    visit(input)
  end

  def packet_scanners_pt2(input) do
    visit(input)
  end

  defp visit(input, severity \\ 0)
  defp visit([], severity), do: severity
  defp visit([{depth, range} | rest], severity) do
    at_top = (range - 1) * 2
    if rem(depth, at_top) == 0 do
      visit(rest, severity + depth * range)
    else
      visit(rest, severity)
    end
  end
end
