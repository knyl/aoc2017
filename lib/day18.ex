defmodule Day18 do

  def duet_pt1(steps) do
    play(steps)
  end

  def duet_pt2(steps) do
    duet(steps)
  end

  defp play(steps, curr_pos \\ 0, registers \\ %{}, sound \\ {%{}, -1}) do
    step = Enum.at(steps, curr_pos)
    case play_step(step, curr_pos, registers, sound) do
      {nil, _regs, {_, last}} -> last
      {next_pos, regs, sounds} -> play(steps, next_pos, regs, sounds)
    end
  end

  defp play_step(["set", reg, value], pos, registers, sound), do: set(reg, value, pos, registers, sound)
  defp play_step(["mul", reg, value], pos, registers, sound), do: mul(reg, value, pos, registers, sound)
  defp play_step(["add", reg, value], pos, registers, sound), do: add(reg, value, pos, registers, sound)
  defp play_step(["mod", reg, value], pos, registers, sound), do: mod(reg, value, pos, registers, sound)
  defp play_step(["snd", reg], pos, registers, sound), do: snd(reg, pos, registers, sound)
  defp play_step(["rcv", reg], pos, registers, sound), do: rcv(reg, pos, registers, sound)
  defp play_step(["jgz", reg, value], pos, registers, sound), do: jgz(reg, value, pos, registers, sound)

  defp set(reg, value, pos, registers, sound) do
    val = get_value(value, registers)
    {pos + 1, Map.put(registers, reg, val), sound}
  end

  defp mul(reg, value, pos, registers, sound) do
    val = get_value(value, registers)
    v = Map.get(registers, reg, 0)
    {pos + 1, Map.put(registers, reg, v * val), sound}
  end

  defp add(reg, value, pos, registers, sound) do
    val = get_value(value, registers)
    v = Map.get(registers, reg, 0)
    {pos + 1, Map.put(registers, reg, v + val), sound}
  end

  defp mod(reg, value, pos, registers, sound) do
    val = get_value(value, registers)
    v = Map.get(registers, reg, 0)
    {pos + 1, Map.put(registers, reg, rem(v, val)), sound}
  end

  defp snd(reg, pos, registers, {sound, _}) do
    snd = Map.get(registers, reg, 0)
    {pos + 1, registers, {Map.put(sound, reg, snd), snd}}
  end

  defp rcv(reg, pos, registers, sound) do
    if Map.get(registers, reg, 0) != 0 do
      {nil, registers, sound}
    else
      {pos + 1, registers, sound}
    end
  end

  defp jgz(reg, value, pos, registers, sound) do
    if Map.get(registers, reg, 0) > 0 do
      val = get_value(value, registers)
      {pos + val, registers, sound}
    else
      {pos + 1, registers, sound}
    end
  end

  defp get_value(value, registers) do
    case Integer.parse(value) do
      {val, ""} -> val
      :error -> registers[value]
    end
  end

  defp duet(steps) do
    pid0 = spawn(fn -> wait_for_start(steps) end)
    pid1 = spawn(fn -> wait_for_start(steps) end)
    send pid1, {:process, %{:pid => pid0, :parent => self(), :start => 1, :sent => 0}}
    send pid0, {:process, %{:pid => pid1, :parent => self(), :start => 0, :sent => 0}}
    IO.puts "pid1 #{inspect(pid1)}"

    receive do
      {:done, rec_pid, res} when rec_pid == pid1 -> res
    end
  end

  defp wait_for_start(steps) do
    receive do
      {:process, state} -> do_duet(steps, Map.put(state, :len, length(steps)))
    end
  end

  defp do_duet(steps, state, registers \\ %{}, curr_pos \\ 0) do
    step = Enum.at(steps, curr_pos)
    case play_step2(step, state, curr_pos, registers) do
      {:done, _regs, updated_state} ->
        IO.puts "done #{inspect(updated_state.sent)} pid #{inspect(self())}"
        send(state.parent, {:done, self(), updated_state.sent})
      {next_pos, regs, updated_state} -> do_duet(steps, updated_state, regs, next_pos)
    end
  end

  defp play_step2(["set", reg, value], state, pos, registers), do: set2(reg, state, value, pos, registers)
  defp play_step2(["mul", reg, value], state, pos, registers), do: mul2(reg, state, value, pos, registers)
  defp play_step2(["add", reg, value], state, pos, registers), do: add2(reg, state, value, pos, registers)
  defp play_step2(["mod", reg, value], state, pos, registers), do: mod2(reg, state, value, pos, registers)
  defp play_step2(["snd", reg], state, pos, registers), do: snd2(reg, state, pos, registers)
  defp play_step2(["rcv", reg], state, pos, registers), do: rcv2(reg, state, pos, registers)
  defp play_step2(["jgz", reg, value], state, pos, registers), do: jgz2(reg, state, value, pos, registers)

  defp set2(reg, state, value, pos, registers) do
    val = get_value2(value, registers, state.start)
    {pos + 1, Map.put(registers, reg, val), state}
  end

  defp mul2(reg, state, value, pos, registers) do
    val = get_value2(value, registers, state.start)
    v = Map.get(registers, reg, state.start)
    {pos + 1, Map.put(registers, reg, v * val), state}
  end

  defp add2(reg, state, value, pos, registers) do
    val = get_value2(value, registers, state.start)
    v = Map.get(registers, reg, state.start)
    {pos + 1, Map.put(registers, reg, v + val), state}
  end

  defp mod2(reg, state, value, pos, registers) do
    val = get_value2(value, registers, state.start)
    v = Map.get(registers, reg, state.start)
    {pos + 1, Map.put(registers, reg, rem(v, val)), state}
  end

  defp snd2(reg, state, pos, registers) do
    val = get_value2(reg, registers, state.start)
    IO.puts "#{inspect(self())} sending #{inspect(val)}"
    send(state.pid, {:value, val})
    send(state.parent, {:back, self(), val})
    {pos + 1, registers, Map.put(state, :sent, state.sent + 1)}
  end

  defp rcv2(reg, state, pos, registers) do
    receive do
      {:value, val} ->
        IO.puts "#{inspect(self())} receiving #{inspect(val)}"
        {pos + 1, Map.put(registers, reg, val), state}
      after
        5000 -> {:done, registers, state}
    end
  end

  defp jgz2(reg, state, value, pos, registers) do
    next = get_value2(value, registers, state.start) + pos
    reg_val = Map.get(registers, reg, state.start)
    cond do
      reg_val > 0 && (next + pos < 0 || pos + next >= state.len) -> send(state.parent, {:done, registers, state})
      reg_val > 0 -> {pos + next, registers, state}
      true -> {pos + 1, registers, state}
    end
  end

  defp get_value2(value, registers, default) do
    case Integer.parse(value) do
      {val, ""} -> val
      :error -> Map.get(registers, value, default)
    end
  end


end
