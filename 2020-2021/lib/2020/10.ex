import AOC

aoc 2020, 10 do
  defmodule Memoization do
    use Agent
    def start_link() do
      Agent.start_link(fn -> %{} end, name: __MODULE__)
    end
    def value(key) do
      Agent.get(__MODULE__, &Map.fetch(&1, key))
    end
    def put(key, value) do
      Agent.update(__MODULE__, &Map.put(&1, key, value))
    end
  end

  def p1 do
    get_input()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [min, max] -> max - min end)
    |> Enum.frequencies()
    |> (fn %{1 => n1, 3 => n3} -> n1 * n3 end).()
  end

  def get_input() do
    input_string()
    |> String.trim()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> append_start_end_voltages()
  end

  def append_start_end_voltages(list) do
    [0] ++ list ++ [(Enum.reverse(list) |> hd()) + 3]
  end

  def p2 do
    Memoization.start_link()
    get_input()
    |> count_permutations()
  end

  def count_permutations([head | tail]) do
    case Memoization.value(head) do
      {:ok, num} -> num
      _ -> result = try_sum(head, tail) +
        try_sum(head, Enum.drop(tail, 1)) +
        try_sum(head, Enum.drop(tail, 2)) +
        try_sum(head, Enum.drop(tail, 3))
        Memoization.put(head, result)
        result
    end
  end

  def try_sum(head, [elem]) when elem - head <= 3, do: 1
  def try_sum(head, tail) when hd(tail) - head <= 3 do
    count_permutations(tail)
  end

  def try_sum(_, _),  do: 0

end
