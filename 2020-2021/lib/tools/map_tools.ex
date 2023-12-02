defmodule MapTools do
  def to_2d_map(list_of_lists) do
    list_of_lists
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, line_number} ->
      line
      |> to_charlist()
      |> Enum.with_index()
      |> Enum.map(fn {char, column_number} -> {{line_number, column_number}, char} end)
    end)
    |> Map.new()
  end

  def string_to_2d_map(str) do
    str
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> to_2d_map()
  end

  def point_sum({a, b}, {c, d}), do: {a + c, b + d}
  def point_operation({a, b}, {c, d}, f), do: {f.(a, c), f.(b, d)}

  def draw_map(map, lines, columns) do
    map = Enum.map(map, fn pos -> {pos, ?#} end) |> Map.new()
    0..lines * columns - 1
    |> Enum.map(&Map.get(map, {rem(&1, columns), div(&1, columns)}, ?.))
    |> Enum.chunk_every(columns)
    |> Enum.join("\n")
    |> then(&(&1 <> "\n"))
  end
end
