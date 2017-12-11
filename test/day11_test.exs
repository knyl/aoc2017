defmodule Day11Test do
  use ExUnit.Case

  test "test 1 pt1" do
    assert Day11.hex_ed_pt1(["sw", "sw"]) == 2
  end

  test "test 2 pt1" do
    assert Day11.hex_ed_pt1(["sw", "sw", "s", "s", "ne"]) == 3
  end

  test "test 1 pt2" do
    assert Day11.hex_ed_pt2(["sw", "sw", "s", "s", "ne"]) == 4
  end
end
