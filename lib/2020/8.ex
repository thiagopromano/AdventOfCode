import AOC

aoc 2020, 8 do
  # def input_string(),
  #   do: """
  #   nop +0
  #   acc +1
  #   jmp +4
  #   acc +3
  #   jmp -3
  #   acc -99
  #   acc +1
  #   jmp -4
  #   acc +6
  #   """

  def p1 do
    pid = get_instructions()
    |> spawn_calculator()

    result = get_acc_on_loop(pid, MapSet.new())
    send(pid, :exit)
    result
  end
  def get_instructions do
    input_string()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&to_tuple/1)
    |> List.to_tuple()
  end
  def to_tuple(line) do
    [instruction, value] = String.split(line)
    {String.to_atom(instruction), String.to_integer(value)}
  end

  def spawn_calculator(instructions) do
    spawn(fn -> loop(%{instructions: instructions, curr: 0, acc: 0}) end)
  end

  def get_acc_on_loop(pid, set) do
    send(pid, {self(), :next_state})

    receive do
      %{curr: curr, acc: acc} ->
        if MapSet.member?(set, curr) do
          acc
        else
          get_acc_on_loop(pid, MapSet.put(set, curr))
        end
    end
  end

  def loop(state) do
    receive do
      :exit ->
        IO.puts("exiting")

      {sender_pid, :next_state} ->
        state = next_state(state)
        send(sender_pid, state)
        loop(state)
    end
  end

  def next_state(state = %{instructions: instructions, curr: curr, acc: acc}) do
    current_instruction = elem(instructions, curr)
    {to_jmp, to_add} = execute_instruction(current_instruction)
    %{state | curr: curr + to_jmp, acc: acc + to_add}
  end

  def execute_instruction({:nop, _val}), do: {1, 0}
  def execute_instruction({:jmp, val}), do: {val, 0}
  def execute_instruction({:acc, val}), do: {1, val}

  def p2 do
  end

end
