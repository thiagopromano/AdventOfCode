import AOC

aoc 2020, 9 do
  # def input_string(),
    # do: """
    # 35
    # 20
    # 15
    # 25
    # 47
    # 40
    # 62
    # 55
    # 65
    # 95
    # 102
    # 117
    # 150
    # 182
    # 127
    # 219
    # 299
    # 277
    # 309
    # 576
    # """

  @preamble_size 25

  def p1, do: do_p1()

  def do_p1 do
    get_input_list()
    |> find_wrong_number()
  end

  def get_input_list() do
    input_string()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  def find_wrong_number(sequence) do
    sequence
    |> Enum.with_index()
    |> Enum.drop(@preamble_size)
    |> Enum.find(fn {curr, idx} ->
        get_previous_sequence(sequence, idx)
        |> all_combinations
        |> Enum.member?(curr)
        |> Kernel.not()
    end)
    |> elem(0)
  end

  def get_previous_sequence(sequence, idx) do
    sequence
    |> Enum.drop(idx - @preamble_size)
    |> Enum.take(@preamble_size)
  end

  def all_combinations(sequence) do
    sequence_with_index = Enum.with_index(sequence)

    for {number_a, idxa} <- sequence_with_index,
        {number_b, idxb} <- sequence_with_index,
        idxa != idxb do
      number_a + number_b
    end
  end

  def p2 do
    number_to_find = do_p1()
    get_input_list()
    |> find_contiguous(number_to_find)
    |> Enum.min_max()
    |> Tuple.to_list()
    |> Enum.sum()
  end

  def find_contiguous(sequence, number_to_find) do
    2..150
    |> Enum.find_value(fn current_chunk_size ->
        Enum.chunk_every(sequence, current_chunk_size, 1)
        |> Enum.find(fn chunk ->
          chunk
          |> Enum.sum()
          |> Kernel.==(number_to_find)
        end)
    end)
  end
end
