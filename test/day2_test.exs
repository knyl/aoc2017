defmodule Day2Test do
  use ExUnit.Case

  test "Simple case" do
    assert Day2.corruption_checksum_pt1([[1, 2, 5], [4, 5, 6]]) == 6
  end
end
