defmodule Day10Test do
  use ExUnit.Case

  test "test 1 pt1" do
    assert Day10.knot_hash_pt1([3, 4, 1, 5], 0..4) == 12
  end

  test "test 1 pt2" do
    assert Day10.knot_hash_pt2("") == "a2582a3a0e66e6e86e3812dcb672a272"
  end

  test "test 2 pt2" do
    assert Day10.knot_hash_pt2("AoC 2017") == "33efeb34ea91902bb2f59c9920caa6cd"
  end

  test "test 3 pt2" do
    assert Day10.knot_hash_pt2("1,2,3") == "3efbe78a8d82f29979031a4aa0b16a9d"
  end

  test "test 4 pt2" do
    assert Day10.knot_hash_pt2("1,2,4") == "63960835bcdc130f0b66d7ff4f6a5a8e"
  end
end
