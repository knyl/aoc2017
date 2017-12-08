defmodule Day8Test do
  use ExUnit.Case

  test "test pt1" do
  input = [ "b inc 5 if a > 1",
            "a inc 1 if b < 5",
            "c dec -10 if a >= 1",
            "c inc -20 if c == 10"]
    assert Day8.like_registers_pt1(input) == 1
  end

  test "test 2 pt1" do
  input = [ "b inc 5 if a > 1",
            "a inc 1 if b < 5",
            "c dec -10 if a >= 1",
            "c dec -10 if a != 2",
            "c inc -20 if c == 10"]
    assert Day8.like_registers_pt2(input) == 20
  end

end
