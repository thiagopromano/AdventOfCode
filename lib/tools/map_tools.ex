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

  def point_sum({a, b}, {c, d}), do: {a + c, b + d}
end
