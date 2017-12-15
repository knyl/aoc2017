defmodule Day15Test do
  use ExUnit.Case

  test "test 1 pt1" do
    assert Day15.dueling_generators_pt1(65, 8921) == 588
  end

  test "test 1 pt2" do
    assert Day15.dueling_generators_pt2(65, 8921) == 309
  end
end
