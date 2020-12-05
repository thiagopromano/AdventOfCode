import AOC

aoc 2020, 4 do
  def p1 do
    input_string()
    |> String.split("\n\n")
    |> Enum.map(&is_valid1?/1)
    |> Enum.count(&(&1 == true))
  end

  def p2 do
    input_string()
    |> String.split("\n\n")
    |> Enum.map(&is_valid2?/1)
    |> Enum.count(&(&1 == true))
  end

  @required_fields [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid]
  def required_fields_with_validation, do: [
    byr: &between?(&1, 1920, 2002),
    iyr: &between?(&1, 2010, 2020),
    eyr: &between?(&1, 2020, 2030),
    hgt: &valid_height?/1,
    hcl: &String.match?(&1, ~r/^#[0-9a-f]{6}$/),
    ecl: &String.match?(&1, ~r/^(amb|blu|brn|gry|grn|hzl|oth)$/),
    pid: &String.match?(&1, ~r/^\d{9}$/),
  ]

  def is_valid1?(input) do
    input
    |> to_map()
    |> has_all_fields?()
  end

  def is_valid2?(input) do
    input
    |> to_map()
    |> all_fields_valid?()
  end

  def all_fields_valid?(input) do
    required_fields_with_validation()
    |> Enum.all?(fn {key, test} -> test.(Map.get(input, key, "")) end)
  end

  def to_map(input) do
    input
    |> String.split()
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(fn [name, value] -> {String.to_atom(name), value} end)
    |> Enum.into(%{})
  end

  def has_all_fields?(input) do
    @required_fields
    |> Enum.all?(&Map.has_key?(input, &1))
  end

  def between?("", _ , _), do: false
  def between?(val, min, max) when is_binary(val), do: between?(String.to_integer(val), min, max)
  def between?(val, min, max), do: min <= val and val <= max

  def valid_height?(height_str) do
    Integer.parse(height_str)
    |> case do
      {size, "cm"} -> between?(size, 150, 193)
      {size, "in"} -> between?(size, 59, 76)
      _ -> false
    end
  end
end
