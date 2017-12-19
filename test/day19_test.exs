defmodule Day19Test do
  use ExUnit.Case

  test "test 1 pt1" do
    input = ["     |         ",
             "     |  +--+   ",
             "     A  |  C   ",
             " F---|----E|--+",
             "     |  |  |  D",
             "     +B-+  +--+"]
    assert Day19.tubes_pt1(input) == "ABCDEF"
  end

end
