import AOC

aoc 2020, 2 do
  use Bitwise

  def p1 do
    read_file()
    |> Enum.map(&with_fields/1)
    |> Enum.map(&with_count/1)
    |> Enum.filter(&valid_password1?/1)
    |> Enum.count()
  end

  def p2 do
    read_file()
    |> Enum.map(&with_fields/1)
    |> Enum.filter(&valid_password2?/1)
    |> Enum.count()
  end

  def valid_password2?(%{min: min, max: max, letter: letter, string: string}) do
    first_letter =
      String.graphemes(string)
      |> Enum.at(min - 1)

    second_letter =
      String.graphemes(string)
      |> Enum.at(max - 1)

    has_first = first_letter == letter
    has_second = second_letter == letter
    (has_first && !has_second) || (!has_first && has_second)
  end

  def valid_password1?(%{min: min, max: max, letter: letter, count: count}) do
    amount = Map.get(count, letter, -1)
    amount <= max && amount >= min
  end

  def with_fields(line) do
    [range, letter_with_colon, string] = String.split(line)

    {min, max} = extract_min_max(range)
    [letter | _] = String.graphemes(letter_with_colon)

    %{original: line, min: min, max: max, letter: letter, string: string}
  end

  def with_count(data = %{string: string}) do
    Map.put(data, :count, count_ocurrences(string))
  end

  def extract_min_max(range) do
    [startstr, endstr] = String.split(range, "-")
    {String.to_integer(startstr), String.to_integer(endstr)}
  end

  def count_ocurrences(string) do
    string
    |> String.graphemes()
    |> Enum.reduce(%{}, fn char, acc ->
      Map.update(acc, char, 1, &(&1 + 1))
    end)
  end

  def read_file() do
    input_stream()
    |> Stream.map(&String.replace(&1, "\n", ""))
  end
end
