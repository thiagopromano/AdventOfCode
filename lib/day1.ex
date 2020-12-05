defmodule Day1 do
  def get_report do
    read_file()
    |> to_tuple()
  end

  def read_file() do
    File.stream!("day01.in")
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&String.to_integer/1)
  end

  @spec to_tuple(any) :: [any]
  def to_tuple(list) do
    for a <- list, b <- list , c <- list, a+b+c == 2020 do
      {a, b, c, a+b+c, a*b*c}
    end
  end
end
