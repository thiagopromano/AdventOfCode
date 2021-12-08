import AOC

aoc 2021, 8 do
  use InputHelper

  def get_input do
    input_string()
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&line_to_input/1)
  end

  def line_to_input(line) do
    line
    |> String.split("|", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> List.to_tuple()
  end

  def p1 do
    digit_frequencies =
      get_input()
      |> Enum.map(&elem(&1, 1))
      |> List.flatten()
      |> Enum.map(&String.length/1)
      |> Enum.frequencies()

    [2, 3, 4, 7]
    |> Enum.map(&Map.fetch!(digit_frequencies, &1))
    |> Enum.sum()
  end

  def p2 do
    get_input()
    |> Enum.map(&to_charlists/1)
    |> Enum.map(&get_output_value_for_line/1)
    |> Enum.sum()
  end
  defp to_charlists({a, b}), do: {Enum.map(a, &String.to_charlist/1), Enum.map(b, &String.to_charlist/1)}

  def get_output_value_for_line({tests, digits_turned_on}) do
    mapping = MathTools.permutations(~c"abcdefg")
    |> Enum.map(&to_mapping/1)
    |> Enum.find(&valid_mapping?(&1, tests))

    digits_turned_on
    |> Enum.map(&apply_mapping(&1, mapping))
    |> Enum.map(&to_digit/1)
    |> List.to_integer()
  end


  def to_mapping(permutation) do
    Enum.zip(permutation, ~c"abcdefg")
    |> Map.new()
  end

  def valid_mapping?(mapping, tests) do
    tests
    |> Enum.map(&apply_mapping(&1, mapping))
    |> Enum.all?(&valid_digit?/1)
  end

  def apply_mapping(symbol, mapping) do
    symbol
    |> Enum.map(&Map.fetch!(mapping, &1))
  end

  @digits [
    ~c"abcefg",
    ~c"cf",
    ~c"acdeg",
    ~c"acdfg",
    ~c"bcdf",
    ~c"abdfg",
    ~c"abdefg",
    ~c"acf",
    ~c"abcdefg",
    ~c"abcdfg"
  ]

  def valid_digit?(checking) do
    Enum.member?(@digits, checking |> Enum.sort())
  end

  def to_digit(mapped) do
    sorted = mapped |> Enum.sort()
    Enum.find_index(@digits, &(&1 == sorted)) + ?0
  end
end
