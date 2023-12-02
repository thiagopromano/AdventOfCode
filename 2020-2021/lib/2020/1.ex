import AOC

aoc 2020, 1 do

  def p1 do
    read_file()
    |> to_tuple1()
  end

  def p2 do
    read_file()
    |> to_tuple2()
  end

  def read_file() do
    input_stream()
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&String.to_integer/1)
  end

  def to_tuple2(list) do
    for a <- list, b <- list, c <- list, a + b + c == 2020 do
      {a, b, c, a + b + c, a * b * c}
    end
  end

  def to_tuple1(list) do
    for a <- list, b <- list, a + b == 2020 do
      {a, b, a + b, a * b}
    end
  end
end
