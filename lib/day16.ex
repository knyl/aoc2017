defmodule Day16 do

  def permutation_promenade_pt1(moves, sequence) do
    dance(moves, sequence)
  end

  def permutation_promenade_pt2(moves, sequence) do
    {_, s, _} = Enum.reduce(1..1_000_000_000, {moves, sequence, %{}}, &dance_repeat/2)
    s
  end

  defp dance_repeat(_, {moves, sequence, map}) do
    case Map.fetch(map, sequence) do
      {:ok, value} -> {moves, value, map}
      :error ->
        updated_sequence = dance(moves, sequence)
        {moves, updated_sequence, Map.put(map, sequence, updated_sequence)}
    end
  end

  defp dance([], sequence), do: sequence
  defp dance(["s" <> num | moves], sequence), do: do_spin(String.to_integer(num), moves, sequence)
  defp dance(["x" <> instr | moves], sequence), do: do_exchange(instr, moves, sequence)
  defp dance(["p" <> instr | moves], sequence), do: do_partner(instr, moves, sequence)

  defp do_spin(num, moves, sequence) do
    {a, b} = String.split_at(sequence, -num)
    dance(moves, b <> a)
  end

  defp do_partner(instruction, moves, sequence) do
    [a, b] = String.split(instruction, "/")
    updated_string = switch(a, b, sequence)
    dance(moves, updated_string)
  end

  defp do_exchange(instruction, moves, sequence) do
    [str1, str2] = String.split(instruction, "/")
    pos1 = String.to_integer(str1)
    pos2 = String.to_integer(str2)
    a = String.at(sequence, pos1)
    b = String.at(sequence, pos2)
    updated_string = switch(a, b, sequence)
    dance(moves, updated_string)
  end

  defp switch(a, b, sequence) do
    sequence
    |> String.replace(a, "1")
    |> String.replace(b, a)
    |> String.replace("1", b)
  end
end
