defmodule Day21Test do

  def fractal_art_pt1(input) do
    {patterns3, patterns4} = parse_input(input)
  end

  defp parse_input(input, two \\ %{}, three \\ %{})
  defp parse_input([], two, three), do: {two, three}
  defp parse_input([row | input], two, three) do
    parsed_row = parse_row(row)
    cond do
      {[[_,_],_],_} = parsed_row -> handle_two(parsed_row, two, three)
      {[[_,_,_,]|_],_} = parsed_row -> handle_three(parsed_row, two, three)
    end
  end

  defp parse_row(row) do
  end

  defp handle_two(row, two, three) do
  end

  defp handle_three(row, two. three) do
  end

  defp rotate_pattern(pattern) do
    fv = flip_vertical(pattern)
    fh = flip_horizontal(pattern)
    rl = rotate_left(pattern)
    rr = rotate_right(pattern)
    rt = rotate_two(pattern)
    [pattern, fv, fh, rl, rr, rt]
  end

  defp flip_vertical(pattern) do
  end

  defp flip_horizontal(pattern) do
  end

  defp rotate_right(pattern) do
  end

  defp rotate_left(pattern) do
  end

  defp rotate_two(pattern) do
  end
end
