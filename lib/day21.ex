defmodule Day212 do

  def fractal_art_pt1(input) do
    {patterns2, patterns3} = parse_input(input)
    start = [".#.","..#","###"]
    new_pattern = patterns3[start]
    result = fractal(new_pattern, patterns2, 4)
    count_hash(result)
  end

  defp count_hash(result) do
    Enum.sum(Enum.map(result, fn(x) -> length(String.split(x, "#")) - 1 end))
  end

  defp fractal(p, _, 0), do: p
  defp fractal(pattern, two, i) do
    new_pattern = find_match(pattern, two)
    fractal(new_pattern, two, i-1)
  end

  defp find_match(pattern, two) do
    pattern
    |> make_squares
    |> Enum.map(fn (x) -> Map.get(two, x) end)
    |> make_into_square
  end

  defp make_squares(squares) do
    squares
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&Enum.chunk_every(&1, 2))
    |> Enum.chunk_every(2)
    |> Enum.map(&Enum.zip/2)
    |> Enum.map(&Enum.map(&1, fn ({a, b}) -> List.to_string(a) <> List.to_string(b) end))
    |> List.flatten
  end

  defp make_into_square(strings) do
    strings
  end

  defp parse_input(input, two \\ %{}, three \\ %{})
  defp parse_input([], two, three), do: {two, three}
  defp parse_input([row | input], two, three) do
    parsed_row = parse_row(row)
    case parsed_row do
      {[_,_],_} -> parse_input(input, do_rotate(parsed_row, two), three)
      {[_,_,_],_} -> parse_input(input, two, do_rotate(parsed_row, three))
    end
  end

  defp parse_row(row) do
    [pattern, result] = String.split(row, " => ")
    patterns = String.split(pattern, "/")
    results = String.split(result, "/")
    {patterns, results}
  end

  defp do_rotate({pattern, result}, map) do
    fv = square_to_string(flip_vertical(pattern))
    fh = square_to_string(flip_horizontal(pattern))
    rl = square_to_string(rotate_left(pattern))
    rr = square_to_string(rotate_right(pattern))
    rt = square_to_string(rotate_two(pattern))
    map
    |> Map.put(pattern, result)
    |> Map.put(fv, result)
    |> Map.put(fh, result)
    |> Map.put(rl, result)
    |> Map.put(rr, result)
    |> Map.put(rt, result)
  end

  defp square_to_string([a, c]), do: a<>c

  defp flip_vertical(pattern) do
    Enum.map(pattern, fn(s) -> String.reverse(s) end)
  end

  defp flip_horizontal(pattern) when length(pattern) == 2 do
    [Enum.at(pattern, 1), Enum.at(pattern, 0)]
  end
  defp flip_horizontal(pattern) when length(pattern) == 3 do
    [Enum.at(pattern, 2), Enum.at(pattern, 1), Enum.at(pattern, 0)]
  end

  defp rotate_left(pattern) when length(pattern) == 2 do
    first = Enum.reverse(List.flatten(Enum.map(pattern, fn(x) -> String.at(x, 0) end)))
    second = Enum.reverse(List.flatten(Enum.map(pattern, fn(x) -> String.at(x, 1) end)))
    [first, second]
  end
  defp rotate_left(pattern) when length(pattern) == 3 do
    first = Enum.reverse(List.flatten(Enum.map(pattern, fn(x) -> String.at(x, 0) end)))
    second = Enum.reverse(List.flatten(Enum.map(pattern, fn(x) -> String.at(x, 1) end)))
    third = Enum.reverse(List.flatten(Enum.map(pattern, fn(x) -> String.at(x, 2) end)))
    [first, second, third]
  end

  defp rotate_right(pattern) when length(pattern) == 2 do
    first = Enum.reverse(List.flatten(Enum.map(pattern, fn(x) -> String.at(x, 1) end)))
    second = Enum.reverse(List.flatten(Enum.map(pattern, fn(x) -> String.at(x, 0) end)))
    [first, second]
  end
  defp rotate_right(pattern) when length(pattern) == 3 do
    first = Enum.reverse(List.flatten(Enum.map(pattern, fn(x) -> String.at(x, 2) end)))
    second = Enum.reverse(List.flatten(Enum.map(pattern, fn(x) -> String.at(x, 1) end)))
    third = Enum.reverse(List.flatten(Enum.map(pattern, fn(x) -> String.at(x, 0) end)))
    [first, second, third]
  end

  defp rotate_two(pattern) do
    flip_horizontal(flip_vertical(pattern))
  end
end
