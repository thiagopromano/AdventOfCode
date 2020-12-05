import AOC

aoc 2020, 3 do
  use Bitwise

  @width 31
  def p1 do
    read_file()
    |> Stream.with_index()
    |> Stream.map(&fetch_char/1)
    |> Enum.count(&(&1 == "#"))
  end

  def p2 do
    file = read_file()
    |> Enum.with_index()
    count_amper(file, 1, 1) * count_amper(file, 3, 1) * count_amper(file, 5, 1) * count_amper(file, 7, 1) * count_amper(file, 1, 2)
    end

  def count_amper(file, right, down) do
    file
    |> Enum.map(&fetch_char(&1, right, down))
    |> Enum.count(&(&1 == "#"))
  end
  def fetch_char({line, line_num}) do
    line
    |> String.graphemes()
    |> Enum.at(rem(line_num*3, @width))
  end

  def fetch_char({line, line_num}, right, down) do
    case rem(line_num, down) do
      0 ->
        line
        |> String.graphemes()
        |> Enum.at(rem(div(line_num*right,down), @width))
      _ -> "noop"
    end
  end



  def read_file() do
    input_stream()
    |> Stream.map(&String.replace(&1, "\n", ""))
  end
end
