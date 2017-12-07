defmodule Day5Test do
  use ExUnit.Case

  test "0 3 0 1 -3 takes 5 steps" do
    assert Day5.twisty_trampolines_pt1([0, 3, 0, 1, -3]) == 5
  end

  test "0 3 0 1 -3 takes 10 steps" do
    assert Day5.twisty_trampolines_pt2([0, 3, 0, 1, -3]) == 10
  end
end
