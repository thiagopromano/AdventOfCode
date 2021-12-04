import AOC

aoc 2021, 3 do
  def input_string_test do
    """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """
  end

  def get_input do
    input_string()
    |> String.split("\n", trim: true)
    |> Enum.map(&format_line/1)
  end

  def format_line(line) do
    line
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  def p1 do
    input = get_input()
    amount_lines = length(input)
    sum = Enum.reduce(input, &MathTools.pointwise_sum/2)

    gamma =
      Enum.map(sum, fn elem -> elem > amount_lines / 2 end)
      |> bits_to_decimal()

    epsilon =
      Enum.map(sum, fn elem -> elem < amount_lines / 2 end)
      |> bits_to_decimal()

    gamma * epsilon
  end

  defp to_binary(true) do
    "1"
  end

  defp to_binary(false) do
    "0"
  end

  defp to_binary(1) do
    "1"
  end

  defp to_binary(0) do
    "0"
  end

  defp bits_to_decimal(bits) do
    Enum.map(bits, &to_binary/1) |> to_string() |> String.to_integer(2)
  end

  def p2 do
    input = get_input()

    oxigen =
      input
      |> Enum.with_index()
      |> filter(&Kernel.>=/2)
      |> then(&Enum.fetch!(input, &1))
      |> bits_to_decimal()

    co2 =
      input
      |> Enum.with_index()
      |> filter(&Kernel.</2)
      |> then(&Enum.fetch!(input, &1))
      |> bits_to_decimal()

      oxigen*co2
  end

  def filter([{_, index} | []], _), do: index

  def filter(lines, comparator) do
    freq =
      lines
      |> Enum.map(fn {[head | _], _index} -> head end)
      |> Enum.frequencies()

    most_common = if comparator.(Map.get(freq, 1, 0), Map.get(freq, 0, 0)), do: 1, else: 0

    lines
    |> Enum.filter(fn {[head | _], _index} -> head == most_common end)
    |> Enum.map(fn {[_ | tail], index} -> {tail, index} end)
    |> filter(comparator)
  end
end
