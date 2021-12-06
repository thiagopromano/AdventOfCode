import AOC

aoc 2021, 2 do
  def input_string_test do
    """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    """
  end

  def get_input do
    input_string()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&format_line/1)
  end

  # returns a tuple with {horizontal diff, vertical diff}
  def format_line(line) do
    line
    |> String.trim()
    |> String.split()
    |> then(fn [direction, num] -> {direction, String.to_integer(num)} end)
    |> then(fn
      {"forward", num} -> {num, 0}
      {"down", num} -> {0, num}
      {"up", num} -> {0, -num}
    end)
  end

  def p1 do
    get_input()
    |> Enum.reduce(
      {0, 0},
      fn {horizontal, vertical}, {prev_horizontal, prev_vertical} ->
        {prev_horizontal + horizontal, prev_vertical + vertical}
      end
    )
    |> then(fn {horizontal, vertical} -> horizontal * vertical end)
  end

  def p2 do
    get_input()
    |> Enum.reduce(
      {0, 0, 0},
      fn
        {0, vertical}, {prev_horizontal, prev_vertical, prev_aim} ->
          {prev_horizontal, prev_vertical, prev_aim + vertical}

        {horizontal, 0}, {prev_horizontal, prev_vertical, prev_aim} ->
          {prev_horizontal + horizontal, prev_vertical + prev_aim * horizontal, prev_aim}
      end
    )
    |> then(fn {horizontal, vertical, _aim} -> horizontal * vertical end)
  end
end
