defmodule Day3Test do
  use ExUnit.Case

  test "Data from square 1 travels 0 steps" do
    assert Day3.spiral_memory_pt1(1) == 0
  end

  test "Data from square 12 travels 3 steps" do
    assert Day3.spiral_memory_pt1(12) == 3
  end

  test "Data from square 23 travels 2 steps" do
    assert Day3.spiral_memory_pt1(23) == 2
  end

  test "Data from square 25 travels 4 steps" do
    assert Day3.spiral_memory_pt1(25) == 4
  end

  test "Data from square 1024 travels 31 steps" do
    assert Day3.spiral_memory_pt1(1024) == 31 end
end
