defmodule Day11Test do
  use ExUnit.Case

  test "test 1 pt1" do
    assert Day11.hex_ed_pt1(["sw", "sw"]) == 2
  end

  test "test 2 pt1" do
    assert Day11.hex_ed_pt1(["nw", "nw"]) == 2
  end

  test "test 3 pt1" do
    assert Day11.hex_ed_pt1(["ne", "n", "sw"]) == 1
  end

  test "test 4 pt1" do
    assert Day11.hex_ed_pt1(["sw", "sw", "s", "s", "ne"]) == 3
  end

  test "test 1 pt2" do
    assert Day11.hex_ed_pt2(["sw", "sw"]) == 2
  end

  test "test 2 pt2" do
    assert Day11.hex_ed_pt2(["ne", "n", "sw"]) == 2
  end

  test "test 3 pt2" do
    assert Day11.hex_ed_pt2(["sw", "sw", "s", "s", "ne"]) == 4
  end
end
