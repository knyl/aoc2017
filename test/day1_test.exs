defmodule Day1Test do
  use ExUnit.Case

  test "An empty list should return 0" do
    assert Day1.inverse_captcha_pt1([]) == 0
  end

  test "List of length 1 should return 0" do
    assert Day1.inverse_captcha_pt1([1]) == 0
    assert Day1.inverse_captcha_pt1([0]) == 0
  end

  test "A list with no matching digits should return 0" do
    assert Day1.inverse_captcha_pt1([1, 2, 3, 4]) == 0
    assert Day1.inverse_captcha_pt1([10, 7, 4, 9]) == 0
  end

  test "A list with only first and last number matching should return it" do
    assert Day1.inverse_captcha_pt1([4, 3, 5, 7, 4]) == 4
  end

  test "A list with four matching numbers should add them" do
    assert Day1.inverse_captcha_pt1([4, 4, 4, 4]) == 16
  end

  test "A list with some matching numbers should count them correctly.." do
    assert Day1.inverse_captcha_pt1([8, 8, 4, 4]) == 12
  end

  test "The list 1212 should produce 6" do
    assert Day1.inverse_captcha_pt2([1, 2, 1, 2]) == 6
  end
  
  test "The list 1221 should produce 0" do
    assert Day1.inverse_captcha_pt2([1, 2, 2, 1]) == 0
  end

  test "The list 123425 should produce 4" do
    assert Day1.inverse_captcha_pt2([1, 2, 3, 4, 2, 5]) == 4
  end

  test "The list 123123 should produce 12" do
    assert Day1.inverse_captcha_pt2([1, 2, 3, 1, 2, 3]) == 12 
  end

  test "The list 12131415 should produce 4" do
    assert Day1.inverse_captcha_pt2([1, 2, 1, 3, 1, 4, 1, 5]) == 4 
  end
end
