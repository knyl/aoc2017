defmodule Day1 do

  def inverse_captcha_pt1([]), do: 0
  def inverse_captcha_pt1(numbers) when length(numbers) == 1, do: 0
  def inverse_captcha_pt1(numbers) do
    last_number = List.last(numbers)
    numbers_rotated = [last_number | Enum.slice(numbers, 0..length(numbers)-2)]
    do_count_matching(0, numbers, numbers_rotated)
  end

  def inverse_captcha_pt2([]), do: 0
  def inverse_captcha_pt2(numbers) do
    num_length = length(numbers)
    halfway = div(num_length, 2)
    numbers_rotated = Enum.slice(numbers, halfway..num_length-1) ++ Enum.slice(numbers, 0..halfway-1)
    do_count_matching(0, numbers, numbers_rotated)
  end

  defp do_count_matching(acc, [], []), do: acc
  defp do_count_matching(acc, [n|numbers], [n|numbers2]) do
    do_count_matching(acc + n, numbers, numbers2)
  end
  defp do_count_matching(acc, [_|numbers], [_|numbers2]) do
    do_count_matching(acc, numbers, numbers2)
  end
end
