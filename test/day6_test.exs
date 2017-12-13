defmodule Day6Test do
  use ExUnit.Case

  test "test 1 pt1" do
    assert Day6.memory_reallocation_pt1([0, 2, 7, 0]) == 5
  end

  test "test 1 pt2" do
    assert Day6.memory_reallocation_pt2([0, 2, 7, 0]) == 4
  end
end
