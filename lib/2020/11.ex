import AOC

aoc 2020, 11 do
  # def input_string() do
  #   """
  #   L.LL.LL.LL
  #   LLLLLLL.LL
  #   L.L.L..L..
  #   LLLL.LL.LL
  #   L.LL.LL.LL
  #   L.LLLLL.LL
  #   ..L.L.....
  #   LLLLLLLLLL
  #   L.LLLLLL.L
  #   L.LLLLL.LL
  #   """
  # end

  def p1 do
    get_input()
    |> execute(&calculate_pos_p1/2)
    |> Enum.count(fn {_, n} -> n == ?# end)
  end

  def p2 do
    get_input()
    |> execute(&calculate_pos_p2/2)
    # |> print_map()
    |> Enum.count(fn {_, n} -> n == ?# end)
  end

  def execute({true, map}, _algorithm) do
    map
  end

  def execute({false, map}, algorithm) do
    map
    |> Enum.chunk_every(2500)
    |> Task.async_stream(fn chunk ->
      chunk |> Enum.map(fn {pos, _val} = position -> {pos, algorithm.(position, map)} end)
    end)
    |> Enum.map(fn {:ok, thing} -> thing end)
    |> List.flatten()
    |> Map.new()
    |> (&{Map.equal?(&1, map), &1}).()
    |> execute(algorithm)
  end

  def execute(map, algorithm), do: execute({false, map}, algorithm)

  def get_input() do
    input_string()
    |> String.trim()
    |> to_map()
  end

  def to_map(input) do
    input
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, line_number} ->
      line
      |> to_charlist()
      |> Enum.with_index()
      |> Enum.map(fn {char, column_number} -> {{line_number, column_number}, char} end)
    end)
    |> Map.new()
  end

  def calculate_pos_p1({_pos, ?.}, _map), do: ?.

  def calculate_pos_p1({pos, ?L}, map) do
    if count_occupied_adjacent(pos, map) == 0 do
      ?#
    else
      ?L
    end
  end

  def calculate_pos_p1({pos, ?#}, map) do
    if count_occupied_adjacent(pos, map) >= 4 do
      ?L
    else
      ?#
    end
  end

  def directions(),
    do: [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]

  def count_occupied_adjacent({line, column}, map) do
    directions()
    |> Enum.map(fn {pos_line, pos_column} -> {line + pos_line, column + pos_column} end)
    |> Enum.count(fn pos ->
      case Map.fetch(map, pos) do
        :error -> false
        {:ok, val} -> val == ?#
      end
    end)
  end

  def calculate_pos_p2({_pos, ?.}, _map), do: ?.

  def calculate_pos_p2({pos, ?L}, map) do
    if count_occupied_visible(pos, map) == 0 do
      ?#
    else
      ?L
    end
  end

  def calculate_pos_p2({pos, ?#}, map) do
    if count_occupied_visible(pos, map) >= 5 do
      ?L
    else
      ?#
    end
  end

  def directions_streams() do
    directions()
    |> Enum.map(fn {direction_line, direction_column} = direction ->
      Stream.iterate(direction, fn {line, column} ->
        {line + direction_line, column + direction_column}
      end)
    end)
  end

  def count_occupied_visible(pos, map) do
    directions_streams()
    |> Enum.count(&has_person_this_direction(&1, pos, map))
  end

  def has_person_this_direction(direction_stream, {line, column}, map) do
    direction_stream
    |> Enum.find_value(fn {delta_line, delta_column} ->
      case Map.get(map, {line + delta_line, column + delta_column}) do
        ?# -> :has_person
        ?L -> :doesnt_have_person
        nil -> :doesnt_have_person
        # continue searching
        ?. -> nil
      end
    end)
    |> Kernel.==(:has_person)
  end

  def print_map({bool, map}) do
    IO.puts(bool)
    print_map(map)
  end

  def print_map(map) do
    map
    |> Enum.to_list()
    |> Enum.sort_by(fn {{line, column}, _} -> line * 100 + column end)
    |> Enum.each(fn {{_line, column}, elem} ->
      if column == 0 do
        IO.write("\n")
      end

      IO.write(<<elem>>)
    end)

    IO.write("\n")
    map
  end
end
