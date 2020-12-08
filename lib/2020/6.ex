import AOC

aoc 2020, 6 do
  def p1 do
    input_string()
    |> String.split("\n\n")
    |> Enum.map(&count_different/1)
    |> Enum.sum()
  end

  def count_different(lines) do
    lines
    |> String.replace("\n", "")
    |> String.graphemes()
    |> Enum.uniq()
    |> Enum.count()
  end

  def p2 do
    input_string()
    |> String.split("\n\n")
    |> Enum.map(&count_all_present/1)
    |> Enum.sum()
  end

  def count_all_present(lines) do
    line_count = lines |> String.trim() |> String.split("\n") |> Enum.count()
    lines
    |> String.replace("\n", "")
    |> String.graphemes()
    |> Enum.frequencies()
    |> Enum.filter(fn {_, count} -> count == line_count end)
    |> Enum.count()
  end
end
