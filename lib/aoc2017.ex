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

  def day5_pt1(filename) do
    file_contents = File.read! filename
    string_list = String.split(file_contents, "\n", trim: true)
    numbers = list_of_strings_to_integers(string_list)
    Day5.twisty_trampolines_pt1(numbers)
  end

  def day5_pt2(filename) do
    file_contents = File.read! filename
    string_list = String.split(file_contents, "\n", trim: true)
    numbers = list_of_strings_to_integers(string_list)
    Day5.twisty_trampolines_pt2(numbers)
  end

  def day6_pt1(filename) do
    file_contents = File.read! filename
    string_list = String.split(file_contents, "\t", trim: true)
    string_list2 = Enum.map(string_list, &String.replace(&1, "\n", ""))
    numbers = list_of_strings_to_integers(string_list2)
    Day6.memory_reallocation_pt1(numbers)
  end

  def day6_pt2(filename) do
    file_contents = File.read! filename
    string_list = String.split(file_contents, "\t", trim: true)
    string_list2 = Enum.map(string_list, &String.replace(&1, "\n", ""))
    numbers = list_of_strings_to_integers(string_list2)
    Day6.memory_reallocation_pt2(numbers)
  end

  def day7_pt1(filename) do
    file_contents = File.read! filename
    string_lines = String.split(file_contents, "\n", trim: true)
    Day7.recursive_circus_pt1(string_lines)
  end

  def day7_pt2(filename) do
    file_contents = File.read! filename
    string_lines = String.split(file_contents, "\n", trim: true)
    Day7.recursive_circus_pt2(string_lines)
  end

  def day8_pt1(filename) do
    file_contents = File.read! filename
    string_lines = String.split(file_contents, "\n", trim: true)
    Day8.like_registers_pt1(string_lines)
  end

  def day8_pt2(filename) do
    file_contents = File.read! filename
    string_lines = String.split(file_contents, "\n", trim: true)
    Day8.like_registers_pt2(string_lines)
  end

  def day9_pt1(filename) do
    file_contents = File.read! filename
    Day9.stream_processing_pt1(String.trim(file_contents))
  end

  def day9_pt2(filename) do
    file_contents = File.read! filename
    Day9.stream_processing_pt2(String.trim(file_contents))
  end

  def day10_pt1(filename) do
    file_contents = File.read! filename
    lengths = file_contents
      |> String.replace("\n", "")
      |> String.split(",", trim: true)
      |> list_of_strings_to_integers
    Day10.knot_hash_pt1(lengths, 0..255)
  end

  def day10_pt2(filename) do
    file_contents = File.read! filename
    string = String.replace(file_contents, "\n", "")
    Day10.knot_hash_pt2(string)
  end

  def day11_pt1(filename) do
    file_contents = File.read! filename
    string =
      file_contents
      |> String.replace("\n", "")
      |> String.split(",", trim: true)
    Day11.hex_ed_pt1(string)
  end

  def day11_pt2(filename) do
    file_contents = File.read! filename
    string =
      file_contents
      |> String.replace("\n", "")
      |> String.split(",", trim: true)
    Day11.hex_ed_pt2(string)
  end

  def day12_pt1(filename) do
    file_contents = File.read! filename
    input =
      file_contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " <-> ", trim: true))
    Day12.digital_plumber_pt1(input)
  end

  def day12_pt2(filename) do
    file_contents = File.read! filename
    input =
      file_contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " <-> ", trim: true))
    Day12.digital_plumber_pt2(input)
  end

  def day13_pt1(filename) do
    file_contents = File.read! filename
    list =
      file_contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ": "))
      |> Enum.map(fn ([a, b]) -> {String.to_integer(a), String.to_integer(b)} end)
    Day13.packet_scanners_pt1(list)
  end

  def day13_pt2(filename) do
    file_contents = File.read! filename
    list =
      file_contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ": "))
      |> Enum.map(fn ([a, b]) -> {String.to_integer(a), String.to_integer(b)} end)
    Day13.packet_scanners_pt2(list)
  end

  def day16_pt1(filename) do
    file_contents = File.read! filename
    list =
      file_contents
      |> String.split(",", trim: true)
      |> Enum.map(&String.replace(&1, "\n", ""))
    Day16.permutation_promenade_pt1(list, "abcdefghijklmnop")
  end

  def day16_pt2(filename) do
    file_contents = File.read! filename
    list =
      file_contents
      |> String.split(",", trim: true)
      |> Enum.map(&String.replace(&1, "\n", ""))
    Day16.permutation_promenade_pt2(list, "abcdefghijklmnop")
  end

  def day18_pt1(filename) do
    file_contents = File.read! filename
    list =
      file_contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))
    Day18.duet_pt1(list)
  end

  def day18_pt2(filename) do
    file_contents = File.read! filename
    list =
      file_contents
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " ", trim: true))
    Day18.duet_pt2(list)
  end

  def day19_pt1(filename) do
    file_contents = File.read! filename
    list = file_contents
           |> String.split("\n", trim: true)
    Day19.tubes_pt1(list)
  end

  def day20_pt1(filename) do
    file_contents = File.read! filename
    list = file_contents
           |> String.split("\n", trim: true)
    Day20.particle_swarm_pt1(list)
  end

  def day20_pt2(filename) do
    file_contents = File.read! filename
    list = file_contents
           |> String.split("\n", trim: true)
    Day20.particle_swarm_pt2(list)
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
