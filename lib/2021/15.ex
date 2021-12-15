import AOC

aoc 2021, 15 do
  use InputHelper
  require IEx
  # Could speed up with priority queues

  def get_input() do
    input_string()
    |> MapTools.string_to_2d_map()
    |> Enum.map(fn {pos, num} -> {pos, String.to_integer(num)} end)
    |> Map.new()
  end

  def p1 do
    map = get_input()
    {{max_y, max_x}, _} = Enum.max_by(map, fn {{y, x}, _} -> y + x end)

    pathfinding_1(map, {0, 0}, {max_y , max_x})
  end

  def directions(), do: [{-1, 0}, {0, -1}, {0, 1}, {1, 0}]

  def path_sorter2({_, val1}, {_, val2}) do
    val1 < val2
  end

  def path_sorter1({p1, _}, {p2, _}) do
    p1 < p2
  end

  def p2 do
    map = get_input()
    {{max_y, max_x}, _} = Enum.max_by(map, fn {{y, x}, _} -> y + x end)

    pathfinding_2(map, {0, 0}, {(max_y + 1) * 5 - 1, (max_x + 1) * 5 - 1})
  end

  def inside_bounds({y, x}, {maxy, maxx}) when y < 0 or x < 0 or x > maxx or y > maxy, do: false
  def inside_bounds(_, _), do: true

  def pathfinding_1(map, start, destination),
    do: pathfinding_2(map, start, destination, MapSet.new([{0, 0}]), 0, [], 1, 0)

  def pathfinding_2(map, start, destination),
    do: pathfinding_2(map, start, destination, MapSet.new([{0, 0}]), 0, [], 5, 0)

  def pathfinding_2(_map, destination, destination, _visited_locations, current_risk, _possible_paths, _repetitions, _c), do: current_risk
  def pathfinding_2(map, curr_position, destination, visited_locations, current_risk, possible_paths, repetitions, c) do

    new_possible_paths_this_iteration = directions()
    |> Enum.map(&MapTools.point_sum(&1, curr_position))
    |> Enum.filter(&(inside_bounds(&1, destination) and !MapSet.member?(visited_locations, &1)))
    |> Enum.map(fn new_pos -> {new_pos, normalized_risk(map, new_pos, destination, repetitions) + current_risk} end)


    visited_locations = new_possible_paths_this_iteration
    |> Enum.reduce(visited_locations, fn {pos, _}, loc -> MapSet.put(loc, pos) end)


    [{new_current_position, new_current_risk} | new_possible_paths] =
      Enum.sort(new_possible_paths_this_iteration ++ possible_paths, &path_sorter1/2)
    |> Enum.dedup_by(&elem(&1, 0))
    |> Enum.sort(&path_sorter2/2)
    new_visited_locations = MapSet.put(visited_locations, curr_position)
    pathfinding_2(map, new_current_position, destination, new_visited_locations, new_current_risk, new_possible_paths, repetitions, c + 1)
  end

  def normalized_risk(map, pos, destination, repetitions) do
    {max_y, max_x} = MapTools.point_operation(destination, {repetitions, repetitions}, &div/2) |> MapTools.point_sum({1, 1})

    normalized_pos = MapTools.point_operation(pos, {max_y, max_x}, &rem/2)
    {repetitions_y, repetitions_x} = MapTools.point_operation(pos, {max_y, max_x}, &div/2)

    base_risk = Map.fetch!(map, normalized_pos)
    final_risk = rem(base_risk + repetitions_x + repetitions_y - 1, 9) + 1

    final_risk
  end
end
