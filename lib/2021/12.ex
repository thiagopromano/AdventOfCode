import AOC

aoc 2021, 12 do
  use InputHelper

  defp get_input() do
    input_string()
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.flat_map(&into_paths/1)
    |> to_maps()
    |> Map.replace!("end", [])
  end

  defp into_paths(line) do
    [first, second] = String.split(line, "-")

    cond do
      first == "start" -> [{first, second}]
      second == "start" -> [{second, first}]
      true -> [{first, second}, {second, first}]
    end
  end

  defp to_maps(roads) do
    roads
    |> Enum.reduce(Map.new(), fn {from, to}, map -> Map.update(map, from, [to], &([to] ++ &1)) end)
  end

  def p1 do
    get_input()
    |> calculate_paths_to_end()
  end

  def calculate_paths_to_end(map), do: calculate_paths_to_end(map, MapSet.new(), "start")
  def calculate_paths_to_end(_map, _places_went, "end"), do: 1

  def calculate_paths_to_end(map, places_went, position) do
    possible_places_to_go =
      Map.fetch!(map, position)
      |> Enum.filter(&(is_upcase?(&1) or &1 not in places_went))

    places_went = MapSet.put(places_went, position)

    Enum.map(possible_places_to_go, fn destination ->
      calculate_paths_to_end(map, places_went, destination)
    end)
    |> Enum.sum()
  end

  def is_upcase?(str) do
    ~r/^[A-Z]+$/
    |> Regex.match?(str)
  end

  def p2 do
    get_input()
    |> calculate_paths_to_end_p2()
  end

  def calculate_paths_to_end_p2(map),
    do: calculate_paths_to_end_p2(map, MapSet.new(), "start", false)

  def calculate_paths_to_end_p2(_map, _places_went, "end", _already_visited_small_twice), do: 1

  def calculate_paths_to_end_p2(map, places_went, position, true) do
    possible_places_to_go =
      Map.fetch!(map, position)
      |> Enum.filter(&(is_upcase?(&1) or &1 not in places_went))

    places_went = MapSet.put(places_went, position)

    Enum.map(possible_places_to_go, fn destination ->
      calculate_paths_to_end_p2(map, places_went, destination, true)
    end)
    |> Enum.sum()
  end

  def calculate_paths_to_end_p2(map, places_went, position, false) do
    possible_places_to_go = Map.fetch!(map, position)


    places_went = MapSet.put(places_went, position)
    Enum.map(possible_places_to_go, fn destination ->
      calculate_paths_to_end_p2(
        map,
        places_went,
        destination,
        (!is_upcase?(destination) and destination in places_went)
      )
    end)
    |> Enum.sum()
  end
end
