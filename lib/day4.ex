defmodule Day4 do

  def high_entropy_passphrase_pt1(lines) do
    lines |> Enum.map(&is_passphrase_valid/1)
          |> Enum.count(fn (x) -> x end)
  end

  def high_entropy_passphrase_pt2(lines) do
    lines |> Enum.map(&sort_chars_in_words/1)
          |> Enum.map(&is_passphrase_valid/1)
          |> Enum.count(fn (x) -> x end)
  end

  def is_passphrase_valid(line) do
    uniq_lines = length(Enum.uniq line)
    non_uniq_lines = length(line)
    uniq_lines === non_uniq_lines
  end

  defp sort_chars_in_words(line) do
    line |> Enum.map(&String.codepoints/1)
         |> Enum.map(&Enum.sort/1)
         |> Enum.map(&List.flatten/1)
  end
end
