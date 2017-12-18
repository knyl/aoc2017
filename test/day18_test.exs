defmodule Day18Test do
  use ExUnit.Case

  test "test 1 pt1" do
    input = [["set", "a", "1"],
             ["add", "a", "2"],
             ["mul", "a", "a"],
             ["mod", "a", "5"],
             ["snd", "a"],
             ["set", "a", "0"],
             ["rcv", "a"],
             ["jgz", "a", "-1"],
             ["set", "a", "1"],
             ["jgz", "a", "-2"]]
    assert Day18.duet_pt1(input) == 4
  end

  test "test 1 pt2" do
    input = [["snd", "1"],
             ["snd", "2"],
             ["snd", "p"],
             ["rcv", "a"],
             ["rcv", "b"],
             ["rcv", "c"],
             ["rcv", "d"]]
    assert Day18.duet_pt2(input) == 3
  end

end
