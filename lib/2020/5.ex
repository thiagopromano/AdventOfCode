import AOC

aoc 2020, 5 do
  # def input_string(), do: """
  # FBFBBFFRLR
  # """

  def p1 do
    get_positions()
    |> Enum.map(fn {_, _, id} -> id end)
    |> Enum.max()
  end

  def p2 do
    get_positions()
    |> Enum.map(fn {_, _, id} -> id end)
    |> Enum.sort()
    |> Enum.reduce_while(
      -1,
      fn
        elem, acc when acc + 2 == elem -> {:halt, acc+1}
        elem, _ -> {:cont, elem}
      end
    )
  end

  def get_positions() do
    input_string()
    |> String.split()
    |> Enum.map(&to_position/1)
  end

  def to_position(<<row::binary-size(7), column::binary-size(3)>>) do
    row_number =
      row
      |> substitute_to_binary("F", "B")
      |> String.to_integer(2)

    column_number =
      column
      |> substitute_to_binary("L", "R")
      |> String.to_integer(2)

    {row_number, column_number, row_number * 8 + column_number}
  end

  def substitute_to_binary(string, low, high) do
    string
    |> String.replace(low, "0")
    |> String.replace(high, "1")
  end
end
