defmodule Day7 do

  def recursive_circus_pt1(input) do
    {_weight, children, supported} = parse_day7_input(input)
    names_children = Map.keys(children)
    names_supported = Map.keys(supported)
    names_children -- names_supported
  end

  def recursive_circus_pt2(input) do
    {weight, children, supported} = parse_day7_input(input)
    names_children = Map.keys(children)
    names_supported = Map.keys(supported)
    [first_name] = names_children -- names_supported

    {_, ans} = is_balanced(first_name, weight, children)
    ans
  end

  # Parse the input and divide information into three maps. One for saving
  # the weight of a node, one for listing the children of a node, and one
  # for whether a node has a parent or not (easy way to find the root node)
  defp parse_day7_input(lines) do
    parsed_lines =
     lines |> Enum.map(&String.split/1)
    parse_day7_line(parsed_lines, %{}, %{}, %{})
  end

  defp parse_day7_line([], weight, children, supported) do
    {weight, children, supported}
  end
  defp parse_day7_line([[name, weight] | tail], weight_map, children, supported) do
    updated_weight_map = Map.put(weight_map, name, get_weight(weight))
    parse_day7_line(tail, updated_weight_map, children, supported)
  end
  defp parse_day7_line([[name | rest] | tail], weights, children, supported) do
    [weight, _ | child_nodes] = rest
    updated_weights = Map.put(weights, name, get_weight(weight))
    updated_children = update_children(name, child_nodes, children)
    updated_supported= update_supported(child_nodes, supported)
    parse_day7_line(tail, updated_weights, updated_children, updated_supported)
  end

  defp update_children(name, children, children_map) do
    already_children = Map.get(children_map, name, [])
    new_children = get_children(children)
    Map.put(children_map, name, new_children ++ already_children)
  end

  defp update_supported(children, supported) do
    new_children = get_children(children)
    Enum.reduce(new_children, supported, &update_supported_map/2)
  end

  defp update_supported_map(name, map) do
    already_supported = Map.get(map, name, 0)
    Map.put(map, name, already_supported + 1)
  end

  defp get_weight(string) do
    string |> String.replace("(", "")
           |> String.replace(")", "")
           |> String.to_integer
  end

  defp get_children(list) do
    Enum.map(list, fn (x) -> String.replace(x, ",", "") end)
  end

  defp is_balanced(name, weights, children) do
    case Map.fetch(children, name) do
      {:ok, names} -> do_is_balanced(name, names, weights, children)
      :error -> {:all_same, Map.get(weights, name)}
    end
  end

  defp do_is_balanced(name, names, weights, children) do
    list = Enum.map(names, &is_balanced(&1, weights, children))
    case is_answer_found(list) do
      {:one_unique, _} = r -> r
      [{:one_unique, x}] -> {:one_unique, x}
      [] ->
        all_weights = get_weights(list)
        find_unique_weight(Map.get(weights, name), all_weights)
    end
  end

  defp get_weights(list) do
    Enum.map(list, fn ({_, w}) -> w end)
  end

  defp is_answer_found(list) do
    Enum.filter(list, &is_unique/1)
  end

  defp is_unique({:one_unique, _}), do: true
  defp is_unique(_), do: false

  defp find_unique_weight(own_weight, children_weights) do
    weights = count_weights(children_weights, %{})
    if length(Map.keys(weights)) == 1 do
      {:all_same, {sum_weights(weights), own_weight}}
    else
      {unique_node_weight, diff} = get_weight_diff(weights)
      [{_, own_own_weight}] =
        Enum.filter(children_weights, &filter_weight(&1, unique_node_weight))
      {:one_unique, own_own_weight + diff}
    end
  end

  defp filter_weight({w1, w2}, sum) when w1 + w2 == sum, do: true
  defp filter_weight(sum, sum), do: true
  defp filter_weight(_, _), do: false

  defp count_weights([], map), do: map
  defp count_weights([{w1, w2} | rest], map) do
    count_weights([w1 + w2 | rest], map)
  end
  defp count_weights([weight | rest], map) do
    current_count = Map.get(map, weight, 0)
    count_weights(rest, Map.put(map, weight, current_count + 1))
  end

  defp sum_weights(weights) do
    Enum.reduce(weights, 0, fn ({weight, count}, acc) -> weight*count + acc end)
  end

  # Return the difference between the node with unique weight and the others
  # weight, and also the weight of the node with unique weight.
  defp get_weight_diff(weights) do
    [{unique, _}] = Enum.filter(weights, fn ({_, count}) -> count == 1 end)
    [{non_unique, _} | _] = Enum.filter(weights, fn ({_, count}) -> count != 1 end)
    {unique, non_unique - unique}
  end
end
