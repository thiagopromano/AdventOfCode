import AOC

aoc 2021, 9 do
  use InputHelper

  def p1 do
    get_input()
    |> find_low_points()
    |> Enum.map(&elem(&1, 1))
    |> Enum.map(&(&1 + 1))
    |> Enum.sum()
  end

  def get_input do
    input_string()
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(fn line -> line |> Enum.map(&(&1 - ?0)) end)
    |> MapTools.to_2d_map()
  end

  def directions(), do: [{-1, 0}, {0, -1}, {0, 1}, {1, 0}]

  def find_low_points(map) do
    map
    |> Enum.filter(&is_minimum(&1, map))
  end

  def is_minimum({position, curr_value}, map) do
    directions()
    |> Enum.map(&MapTools.point_sum(&1, position))
    |> Enum.all?(fn comparing_position -> curr_value < Map.get(map, comparing_position, 11) end)
  end

  def p2 do
    map = get_input()

    map
    |> find_low_points()
    |> Enum.map(&elem(&1, 0))
    |> Enum.map(&basin_size_around_position(map, &1))
    |> Enum.sort(&>=/2)
    |> Enum.take(3)
    |> Enum.product()
  end


  def basin_size_around_position(map, position), do: basin_size({MapSet.new(), [position]}, map)
  def basin_size({checked_set, []}, _), do: MapSet.size(checked_set)
  def basin_size({already_checked_set, [checking_position | positions_to_check]}, map) do
      directions()
      |> Enum.map(&MapTools.point_sum(&1, checking_position))
      |> Enum.filter(&is_walkable?(&1, map))
      |> Enum.reduce({already_checked_set, positions_to_check}, fn position, {cs, pc} ->
        MapSet.member?(already_checked_set, position)
        |> case do
          true ->
            {cs, pc}
          false ->
            {MapSet.put(cs, position), [position] ++ pc}
        end
      end)
      |> basin_size(map)
  end

  def is_walkable?(position, map) do
    Map.get(map, position, 9) != 9
  end
end
