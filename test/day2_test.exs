defmodule Day2Test do
  use ExUnit.Case

  test "Simple case" do
    assert Day2.corruption_checksum_pt1([[1, 2, 5], [4, 5, 6]]) == 6
  end

  test "Simple case pt2" do
    assert Day2.corruption_checksum_pt2([[2, 4, 3, 5], [3, 6, 5, 8]]) == 4
  end
  
  test "Simple case pt2 2" do
    assert Day2.corruption_checksum_pt2([[20, 4, 3, 7], [9, 7, 3, 8]]) == 8
  end

  test "Simple case pt2 3" do
    assert Day2.corruption_checksum_pt2([[5, 9, 2, 8], [9, 4, 7, 3], [3, 8, 6, 5]]) == 9
  end

  test "Simple case pt2 4" do
    assert Day2.corruption_checksum_pt2([[5, 99, 2, 8], [9, 4, 7, 3], [3, 8, 6, 5]]) == 9
  end
end
