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

  @doc """
  Solves day 2, part 1 of Advent of Code 2017.

  Input is a filename. The given file should be on the following format:
    <integer>\t<integer>\t ... \t<integer>
    .
    .
    <integer>\t<integer>\t ... \t<integer>

  That is, several lines of tab-separated integers.
  """
  def day2_pt1(filename) do
    file_contents = File.read! filename
    matrix_with_strings = split_file_into_matrix(file_contents, "\t")
    matrix_with_numbers = Enum.map(matrix_with_strings, &list_of_strings_to_integers/1)
    Day2.corruption_checksum_pt1(matrix_with_numbers)
  end

  @doc """
  Input is a filename. The given file should be on the following format:
    <integer>\t<integer>\t ... \t<integer>
    .
    .
    <integer>\t<integer>\t ... \t<integer>

  That is, several lines of tab-separated integers.
  On one line in the matrix, only two numbers are evenly divisible.
  """
  def day2_pt2(filename) do
    file_contents = File.read! filename
    matrix_with_strings = split_file_into_matrix(file_contents, "\t")
    matrix_with_numbers = Enum.map(matrix_with_strings, &list_of_strings_to_integers/1)
    Day2.corruption_checksum_pt2(matrix_with_numbers)
  end

  def day3_pt1(number) do
    Day3.spiral_memory_pt1(number)
  end

  def day3_pt2(number) do
    Day3.spiral_memory_pt2(number)
  end

  def day4_pt1(filename) do
    file_contents = File.read! filename
    lines = split_file_into_matrix(file_contents, " ")
    Day4.high_entropy_passphrase_pt1(lines)
  end

  def day4_pt2(filename) do
    file_contents = File.read! filename
    lines = split_file_into_matrix(file_contents, " ")
    Day4.high_entropy_passphrase_pt2(lines)
  end

  defp split_file_into_matrix(file_contents, word_delimiter) do
    file_contents |> String.split("\n")
                  |> Enum.map(&String.split(&1, word_delimiter))
                  |> Enum.filter(fn(x) -> x != [""] end)
  end

  defp list_of_strings_to_integers(list) do
    Enum.map(list, &String.to_integer/1)
  end
end
