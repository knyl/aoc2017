defmodule Day9 do

  def stream_processing_pt1(input) do
    initial_state = %{garbage: false, garbage_count: 0, count: 0, level: 0}
    updated_state = count_groups(String.codepoints(input), initial_state)
    updated_state.count
  end

  def stream_processing_pt2(input) do
    initial_state = %{garbage: false, garbage_count: 0, count: 0, level: 0}
    updated_state = count_groups(String.codepoints(input), initial_state)
    updated_state.garbage_count
  end

  defp count_groups([], state), do: state
  defp count_groups(["!", _ | rest], state) do
    count_groups(rest, state)
  end
  defp count_groups([">" | rest], %{garbage: true} = state) do
    count_groups(rest, %{state | garbage: false})
  end
  defp count_groups(["<" | rest], %{garbage: false} = state) do
    count_groups(rest, %{state | garbage: true})
  end
  defp count_groups([_ | rest], %{garbage: true} = state) do
    count_groups(rest, %{state | garbage_count: state.garbage_count + 1, garbage: true})
  end
  defp count_groups(["{" | rest], %{garbage: false} = state) do
    count_groups(rest, %{state | level: state.level + 1})
  end
  defp count_groups(["}" | rest], %{garbage: false} = state) do
    count_groups(rest, %{state | level: state.level - 1, count: state.count + state.level})
  end
  defp count_groups([_ | rest], %{garbage: false} = state) do
    count_groups(rest, state)
  end
end
