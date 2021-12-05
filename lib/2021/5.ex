import AOC

aoc 2021, 5 do
  def input_string_test do
    """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """
  end

  def get_input do
    input_string()
    |> String.split("\n", trim: true)
    |> Enum.map(&format_line/1)
  end

  defp format_line(line) do
    line
    |> String.split(~r/,|->/, trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> then(fn [a, b, c, d] -> {{a, b}, {c, d}} end)
  end

  def p1 do
    get_input()
    |> Enum.reduce(%{}, &add_line_to_map_p1/2)
    |> Enum.count(fn {_, count} -> count > 1 end)
  end

  defp add_line_to_map_p1(line, map),
    do: add_line_to_map(line, map, &decompose_line_to_positions/1)

  defp add_line_to_map(line, map, decomposer) do
    decomposer.(line)
    |> Enum.reduce(map, fn line, m -> Map.update(m, line, 1, &(&1 + 1)) end)
  end

  defp decompose_line_to_positions({{a, b}, {a, c}}) do
    b..c
    |> Enum.map(fn val -> {a, val} end)
  end

  defp decompose_line_to_positions({{b, a}, {c, a}}) do
    b..c
    |> Enum.map(fn val -> {val, a} end)
  end

  defp decompose_line_to_positions(_) do
    []
  end

  def p2 do
    get_input()
    |> Enum.reduce(%{}, &add_line_to_map_p2/2)
    |> Enum.count(fn {_, count} -> count > 1 end)
  end

  defp add_line_to_map_p2(line, map),
    do: add_line_to_map(line, map, &decompose_line_to_positions_with_diagonals/1)

  defp decompose_line_to_positions_with_diagonals({{a, b}, {a, c}}) do
    b..c
    |> Enum.map(fn val -> {a, val} end)
  end

  defp decompose_line_to_positions_with_diagonals({{b, a}, {c, a}}) do
    b..c
    |> Enum.map(fn val -> {val, a} end)
  end

  defp decompose_line_to_positions_with_diagonals({{a, b}, {c, d}}) do
    Enum.zip(a..c, b..d)
  end
end
