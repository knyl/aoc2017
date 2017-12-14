defmodule Day14Test do
  use ExUnit.Case

  test "test 1 pt1" do
    assert Day14.disk_defragmentation_pt1("flqrgnkx") == 8108
  end

  test "test 1 pt2" do
    assert Day14.disk_defragmentation_pt2("flqrgnkx") == 1242
  end
end
