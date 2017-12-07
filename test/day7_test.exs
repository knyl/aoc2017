defmodule Day7Test do
  use ExUnit.Case

  test "test pt1" do
  input = ["foo (5)",
           "fafa (20) -> foo, fifi, fifo",
           "fifi (10)",
           "fifo (10)"]
    assert Day7.recursive_circus_pt1(input) == ["fafa"]
  end

  test "test pt2" do
    input = ["foo (5) -> xy, xo",
           "fafa (20) -> foo, fifi, fifo",
           "fifi (15)",
           "xy (3)",
           "xo (3)",
           "fifo (15)"]
    assert Day7.recursive_circus_pt2(input) == 9
  end
end
