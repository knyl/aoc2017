defmodule Day13Test do
  use ExUnit.Case

  test "test 1 pt1" do
    assert Day13.packet_scanners_pt1([{0, 3}, {1, 2}, {4, 4}, {6, 4}]) == 24
  end

  test "test 1 pt2" do
    assert Day13.packet_scanners_pt2([{0, 3}, {1, 2}, {4, 4}, {6, 4}]) == 10
  end
end
