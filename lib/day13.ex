defmodule Day13 do

  def packet_scanners_pt1(input) do
    visit(input)
  end

  def packet_scanners_pt2(input) do
    visit_delay(input)
  end

  defp visit(input, offset \\ 0, severity \\ 0)
  defp visit([], _, severity), do: severity
  defp visit([{depth, range} | rest], offset, severity) do
    at_top = (range - 1) * 2
    if rem(depth + offset, at_top) == 0 do
      visit(rest, offset, severity + (offset + depth) * range)
    else
      visit(rest, offset, severity)
    end
  end

  defp visit_delay(input, delay \\ 0) do
    if visit(input, delay) == 0 do
      delay
    else
      visit_delay(input, delay + 1)
    end
  end

end
