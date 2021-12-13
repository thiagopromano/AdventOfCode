import AOC

aoc 2021, 13 do
  use InputHelper

  defp get_input() do
    [dots_str, instructions_str] =
      input_string()
      |> String.trim()
      |> String.split("\n\n", trim: true)

    dots =
      dots_str
      |> String.split(["\n", ","], trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2)
      |> Enum.map(&List.to_tuple/1)

    instructions =
      instructions_str
      |> String.split("\n", trim: true)
      |> Enum.map(
        &(Regex.run(~r/fold along (x|y)=(\d+)/, &1)
          |> Enum.drop(1)
          |> then(fn [axis, val] -> {axis, String.to_integer(val)} end))
      )

    {dots, instructions}
  end

  def p1 do
    {dots, [first_instruction | _]} = get_input()

    apply_instruction(dots, first_instruction)
    |> Enum.count()
  end

  defp apply_instruction(dots, {axis, line}) do
    dots
    |> Enum.map(&fold(&1, axis, line))
    |> Enum.uniq()
  end

  defp fold({x, y}, "x", line) when x < line, do: {x, y}
  defp fold({x, y}, "x", line), do: {line - (x - line), y}

  defp fold({x, y}, "y", line) when y < line, do: {x, y}
  defp fold({x, y}, "y", line), do: {x, line - (y - line)}

  def p2 do
    {dots, instructions} = get_input()

    amount_lines =
      instructions
      |> Enum.reverse()
      |> Enum.find_value(fn
        {"y", num} -> num
        {_, _} -> nil
      end)

      amount_columns =
        instructions
        |> Enum.reverse()
        |> Enum.find_value(fn
          {"x", num} -> num
          {_, _} -> nil
        end)

    Enum.reduce(instructions, dots, &apply_instruction(&2, &1))
    |> MapTools.draw_map(amount_lines, amount_columns)
  end
end
