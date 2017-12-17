defmodule Day17 do

  def spinlock_pt1(steps) do
    {list, next} = move([0], 1, 0, steps, 2017)
    Enum.at(list, next + 1)
  end

  def spinlock_pt2(steps, stop \\ 50000000) do
    move2(0, 1, 0, steps, stop)
  end

  defp move(list, stop, curr_pos, steps, stop) do
    {list, rem(curr_pos + steps, length(list))}
  end
  defp move(list, num, curr_pos, steps, stop) do
    next_pos = rem(curr_pos + steps, length(list)) + 1
    updated_list = List.insert_at(list, next_pos, num)
    move(updated_list, num + 1, next_pos, steps, stop)
  end

  defp move2(after_zero, stop, _curr_pos, _steps, stop) do
    after_zero
  end
  defp move2(after_zero, num, curr_pos, steps, stop) do
    next_pos = rem(curr_pos + steps, num) + 1
    if next_pos == 1 do
      move2(num, num + 1, next_pos, steps, stop)
    else
      move2(after_zero, num + 1, next_pos, steps, stop)
    end
  end
end
