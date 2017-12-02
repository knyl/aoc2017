defmodule Aoc2017 do

  @doc """
  Solves day 1, part 1 of Advent of Code 2017.

  Input is a string consisting of only numbers, i.e. "121212" or "12398"
  """
  def day1_pt1(number_string) do
    numbers = number_string |> String.codepoints |> Enum.map(&String.to_integer/1)
    Day1.inverse_captcha_pt1(numbers)
  end
  
  @doc """
  Solves day 1, part 2 of Advent of Code 2017.

  Input is a string consisting of only numbers, i.e. "121212" or "12398"
  The length of the string is an even number.
  """
  def day1_pt2(number_string) do
    numbers = number_string |> String.codepoints |> Enum.map(&String.to_integer/1)
    Day1.inverse_captcha_pt2(numbers)
  end
end
