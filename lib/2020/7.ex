import AOC

aoc 2020, 7 do
  @gold "shiny gold"

  def p1 do
    input_map = get_input()

    input_map
    |> Enum.map(&can_reach_golden?(input_map, &1))
    |> Enum.count(&(&1 == true))
  end

  def get_input do
    input_string()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&to_maps/1)
    |> Enum.reduce(%{}, fn map, acc -> Map.put(acc, map.bag_name, map.bags_inside) end)
  end

  def to_maps(line_str) do
    [bag_name] = Regex.run(~r/^(.+) bags contain/, line_str, capture: :all_but_first)

    bags_inside =
      Regex.scan(~r/(\d+) ([^,]+) bags?/, line_str, capture: :all_but_first)
      |> Enum.map(fn [number, color] -> {color, String.to_integer(number)} end)
      |> Map.new()

    %{bag_name: bag_name, bags_inside: bags_inside}
  end

  def can_reach_golden?(map, {key, _set}), do: can_reach_golden?(map, key)

  def can_reach_golden?(map, key) do
    set = Map.get(map, key)

    if Map.has_key?(set, @gold) do
      true
    else
      Enum.any?(set, &can_reach_golden?(map, &1))
    end
  end

  def p2 do
    get_input()
    |> bags_inside(@gold)
    |> Kernel.-(1)
  end

  def bags_inside(map, key) do
    result = map
    |> Map.get(key)
    |> Enum.reduce(1, fn {name, amount}, acc -> acc + amount * bags_inside(map, name) end)
    result
  end
end
