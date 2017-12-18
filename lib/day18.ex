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
    send pid1, {:process, pid0, self()}
    send pid0, {:process, pid1, self()}
  end

  defp wait_for_start(steps) do
    receive do
      {:process, pid, parent} -> do_duet(steps, pid, parent)
    end
  end

  defp do_duet(steps, pid, parent, registers \\ %{}, curr_pos \\ 0) do
    step = Enum.at(steps, curr_pos)
    case play_step2(step, pid, parent, curr_pos, registers, length(steps)) do
      {nil, _regs, {_, last}} -> last
      {next_pos, regs, sounds} -> do_duet(steps, pid, parent, next_pos, regs, length(steps))
    end
  end

  defp play_step2(["set", reg, value], _, _, pos, registers, _), do: set2(reg, value, pos, registers)
  defp play_step2(["mul", reg, value], _, _, pos, registers, _), do: mul2(reg, value, pos, registers)
  defp play_step2(["add", reg, value], _, _, pos, registers, _), do: add2(reg, value, pos, registers)
  defp play_step2(["mod", reg, value], _, _, pos, registers, _), do: mod2(reg, value, pos, registers)
  defp play_step2(["snd", reg], pid, parent pos, registers, _), do: snd2(reg, pid, parent, pos, registers)
  defp play_step2(["rcv", reg], _, _, pos, registers, _), do: rcv2(reg, pos, registers)
  defp play_step2(["jgz", reg, value], _, _, pos, registers, len), do: jgz2(reg, value, pos, registers, len)

  defp set2(reg, value, pos, registers) do
    val = get_value(value, registers)
    {pos + 1, Map.put(registers, reg, val)}
  end

  defp mul2(reg, value, pos, registers) do
    val = get_value(value, registers)
    v = Map.get(registers, reg, 0)
    {pos + 1, Map.put(registers, reg, v * val)}
  end

  defp add2(reg, value, pos, registers) do
    val = get_value(value, registers)
    v = Map.get(registers, reg, 0)
    {pos + 1, Map.put(registers, reg, v + val)}
  end

  defp mod2(reg, value, pos, registers) do
    val = get_value(value, registers)
    v = Map.get(registers, reg, 0)
    {pos + 1, Map.put(registers, reg, rem(v, val))}
  end

  defp snd2(reg, pid, parent, pos, registers) do
    val = get_value(reg, registers)
    send pid {:value, val}
    send parent {:back, self(), val}
    {pos + 1, registers}
  end

  defp rcv2(reg, pos, registers) do
    receive do
      {:value, val} ->
        Map.put(registers, reg, val)
    end
  end

  defp jgz2(reg, value, pos, registers, len) do
    if Map.get(registers, reg, 0) > 0 do
      next =  get_value(value, registers) + pos
      if next < 0 do
        :ok
      else if next >= len
        :ok
      else
        {pos + val, registers}
      end
    else
      {pos + 1, registers}
    end
  end

end
