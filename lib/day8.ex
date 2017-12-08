defmodule Day8 do

  @max_value :max_value

  def like_registers_pt1(input) do
    split_input = Enum.map(input, &String.split/1)
    updated_map = do_instructions(split_input, %{})
    updated_map |> Map.delete(@max_value) |> Map.values |> Enum.max
  end

  def like_registers_pt2(input) do
    split_input = Enum.map(input, &String.split/1)
    updated_map = do_instructions(split_input, %{@max_value=> :no})
    Map.get(updated_map, @max_value)
  end

  defp do_instructions([], map), do: map
  defp do_instructions([instruction | rest], map) do
    [register, operation, value, "if", register_cond, condition, cond_val] = instruction
    if try_condition(register_cond, condition, cond_val, map) do
      updated_map = do_operation(register, operation, value, map)
      do_instructions(rest, updated_map)
    else
      do_instructions(rest, map)
    end
  end

  defp try_condition(register, ">", value, map) do
    get_reg(map, register) > String.to_integer(value)
  end
  defp try_condition(register, "<", value, map) do
    get_reg(map, register) < String.to_integer(value)
  end
  defp try_condition(register, ">=", value, map) do
    get_reg(map, register) >= String.to_integer(value)
  end
  defp try_condition(register, "<=", value, map) do
    get_reg(map, register) <= String.to_integer(value)
  end
  defp try_condition(register, "==", value, map) do
    get_reg(map, register) === String.to_integer(value)
  end
  defp try_condition(register, "!=", value, map) do
    get_reg(map, register) !== String.to_integer(value)
  end

  defp get_reg(map, register), do: Map.get(map, register, 0)

  defp put_reg(map, register, value) do
    max_value = get_reg(map, @max_value)
    updated_map =
      case max_value do
      :no -> Map.put(map, @max_value, value)
      max_value ->
        if value > max_value do
          Map.put(map, @max_value, value)
        else
          map
        end
    end
    Map.put(updated_map, register, value)
  end

  defp do_operation(register, "inc", value, map) do
    old_value = get_reg(map, register)
    put_reg(map, register, old_value + String.to_integer(value))
  end
  defp do_operation(register, "dec", value, map) do
    old_value = get_reg(map, register)
    put_reg(map, register, old_value - String.to_integer(value))
  end
end
