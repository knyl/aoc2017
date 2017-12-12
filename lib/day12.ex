defmodule Day12 do

  def digital_plumber_pt1(input) do
    pipes = Enum.reduce(input, %{}, &parse_groups/2)
    visited = process_graph(pipes, ["0"])
    MapSet.size(visited)
  end

  def digital_plumber_pt2(input) do
    graph = Enum.reduce(input, %{}, &parse_groups/2)
    nodes = Map.keys(graph)
    count_groups(graph, nodes)
  end

  defp parse_groups([p, rest], graph) do
    programs = String.split(rest, ",", trim: true) |> Enum.map(&String.trim/1)
    {updated_graph, _} = Enum.reduce(programs, {graph, p}, &update_neighbour/2)
    already_programs = Map.get(updated_graph, p, MapSet.new)
    Map.put(updated_graph, p, MapSet.union(MapSet.new(programs), already_programs))
  end

  defp process_graph(map, to_visit, visited \\ MapSet.new)
  defp process_graph(_, [], visited), do: visited
  defp process_graph(map, [next | to_visit], visited) do
    if MapSet.member?(visited, next) do
      process_graph(map, to_visit, visited)
    else
      to_visit_set = MapSet.new(to_visit)
      neighbours = map[next]
      new_to_visit = MapSet.union(to_visit_set, neighbours)
      process_graph(map, MapSet.to_list(new_to_visit), MapSet.put(visited, next))
    end
  end

  defp update_neighbour(p, {map, p}), do: {map, p}
  defp update_neighbour(neighbour, {map, p}) do
    programs = Map.get(map, neighbour, MapSet.new)
    {Map.put(map, neighbour, MapSet.put(programs, p)), p}
  end

  defp count_groups(graph, nodes, visited \\ MapSet.new, count \\ 0)
  defp count_groups(_, [], _, count), do: count
  defp count_groups(graph, [node | nodes], visited, count) do
    if MapSet.member?(visited, node) do
      count_groups(graph, nodes, visited, count)
    else
      group = process_graph(graph, [node])
      count_groups(graph, nodes, MapSet.union(group, visited), count + 1)
    end
  end
end
