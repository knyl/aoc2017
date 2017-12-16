defmodule Day16Test do
  use ExUnit.Case

  test "test 1 pt1" do
    assert Day16.permutation_promenade_pt1(["s1", "x3/4", "pe/b"], "abcde") == "baedc"
  end

end
