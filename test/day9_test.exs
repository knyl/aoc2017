defmodule Day9Test do
  use ExUnit.Case

  test "test 1 pt1" do
    assert Day9.stream_processing_pt1("{}") == 1
  end

  test "test 2 pt1" do
    assert Day9.stream_processing_pt1("{{{}}}") == 6
  end

  test "test 3 pt1" do
    assert Day9.stream_processing_pt1("{{},{}}") == 5
  end

  test "test 4 pt1" do
    assert Day9.stream_processing_pt1("{{{},{},{{}}}}") == 16
  end

  test "test 5 pt1" do
    assert Day9.stream_processing_pt1("{<{},{},{{}}>}") == 1
  end

  test "test 6 pt1" do
    assert Day9.stream_processing_pt1("{<a>,<a>,<a>,<a>}") == 1
  end

  test "test 7 pt1" do
    assert Day9.stream_processing_pt1("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 9
  end

  test "test 8 pt1" do
    assert Day9.stream_processing_pt1("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 9
  end

  test "test 9 pt1" do
    assert Day9.stream_processing_pt1("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 3
  end

  test "test 1 pt2" do
    assert Day9.stream_processing_pt2("{<a>,<a>,<a>,<a>}") == 4
  end

  test "test 2 pt2" do
    assert Day9.stream_processing_pt2("{{<ab>},{<ab>},{<ab>},{<ab>}}") == 8
  end

  test "test 3 pt2" do
    assert Day9.stream_processing_pt2("{{<!!>},{<!!>},{<!!>},{<!!>}}") == 0
  end

  test "test 4 pt2" do
    assert Day9.stream_processing_pt2("{{<a!>},{<a!>},{<a!>},{<ab>}}") == 17
  end
end
