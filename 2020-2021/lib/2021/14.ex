import AOC

aoc 2021, 14 do
  use InputHelper

  def get_input() do
    [template, pairs] = input_string()
    |> String.split("\n\n", trim: true)

    pair_maps = pairs
    |> String.split("\n", trim: true)
    |> Enum.map(&instruction_to_tuple/1)
    |> Map.new()
    {template|> String.to_charlist(), pair_maps}
  end

  def instruction_to_tuple(instruction) do
    [pair, new_elem] = String.split(instruction, " -> ", trim: true)
    pair = [first, second] = String.to_charlist(pair)
    [new_elem] = String.to_charlist(new_elem)
    {pair, [[first, new_elem], [new_elem, second]]}
  end

  def p1 do
    run_calculation(10)
  end


  def p2 do
    run_calculation(40)
  end

  def run_calculation(times) do
    {template, instructions} = get_input()
    bucket_template = template |> to_buckets()
    first_elem = List.first(template)
    last_elem = List.last(template)

    {min, max} = Enum.reduce(1..times, bucket_template, fn _, current_template -> split_new_polymers(current_template, instructions) end)
    |> Enum.map(fn {elems, amount} -> Enum.zip(elems, Stream.cycle([amount])) end)
    |> List.flatten()
    |> Enum.reduce(Map.new(), fn {key, val}, map -> Map.update(map, key, val, &(&1 + val)) end)
    |> Map.update!(first_elem, &(&1 + 1))
    |> Map.update!(last_elem, &(&1 + 1))
    |> Enum.map(fn {a, b} -> {a, div(b, 2)} end)
    |> Map.new()
    |> Enum.map(&elem(&1, 1))
    |> Enum.min_max()

    max - min
  end

  def to_buckets(template) do
    template
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.frequencies()
  end


  def split_new_polymers(buckets, instructions) do
    buckets
    |> Enum.map(fn {tuple, amount} ->
      Enum.zip(instructions[tuple], Stream.cycle([amount]))
     end)
    |> List.flatten()
    |> Enum.reduce(Map.new(), fn {key, val}, map -> Map.update(map, key, val, &(&1 + val)) end)
  end

end
