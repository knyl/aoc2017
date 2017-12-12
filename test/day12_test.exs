defmodule Day12Test do
  use ExUnit.Case

  test "test 1 pt1" do
    assert Day12.digital_plumber_pt1([["0", "0"]]) == 1
  end

  test "test 2 pt1" do
    list = [["0", "2"], ["1", "1"], ["2", "0, 3, 4"], ["3", "2, 4"], ["4", "2, 3, 6"], ["5", "6"], ["6", "4, 5"]]
    assert Day12.digital_plumber_pt1(list) == 6
  end

  test "test 3 pt1" do
    list = [["0", "2"], ["1", "1, 2"], ["2", "3, 4"], ["3", "2, 4"], ["4", "2, 3, 6"], ["5", "6"], ["6", "4, 5"]]
    assert Day12.digital_plumber_pt1(list) == 7
  end

  test "test 4 pt1" do
    list = [["0", "2"], ["1", "1, 2"], ["2", "3, 4"], ["3", "2, 4"], ["4", "2"], ["5", "6"], ["6", "5"]]
    assert Day12.digital_plumber_pt1(list) == 5
  end

  test "test 5 pt1" do
    list = [["0", "0"], ["1", "1, 2"], ["2", "3, 4"], ["3", "2, 4"], ["4", "2"], ["5", "0"], ["6", "5"]]
    assert Day12.digital_plumber_pt1(list) == 3
  end

  test "test 1 pt2" do
    list = [["0", "2"], ["1", "1"], ["2", "0, 3, 4"], ["3", "2, 4"], ["4", "2, 3, 6"], ["5", "6"], ["6", "4, 5"]]
    assert Day12.digital_plumber_pt2(list) == 2
  end

end
