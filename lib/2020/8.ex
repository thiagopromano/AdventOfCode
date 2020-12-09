import AOC

aoc 2020, 8 do
  def p1 do
    pid =
      get_instructions()
      |> spawn_handheld()

    {:looping, result} = get_acc_on_end_or_loop(pid)
    result
  end

  def get_instructions do
    input_string()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&to_tuple/1)
  end

  def to_tuple(line) do
    [instruction, value] = String.split(line)
    {String.to_atom(instruction), String.to_integer(value)}
  end

  def spawn_handheld(instructions) do
    spawn(fn -> loop(%{instructions: instructions, curr: 0, acc: 0}) end)
  end

  def get_acc_on_end_or_loop(pid, set \\ MapSet.new()) do
    send(pid, {self(), :next_state})

    receive do
      %{curr: curr, acc: acc} ->
        if MapSet.member?(set, curr) do
          send(pid, :exit)
          {:looping, acc}
        else
          get_acc_on_end_or_loop(pid, MapSet.put(set, curr))
        end

      {:finished, acc} ->
        {:notlooping, acc}
    end
  end

  def loop(state = %{acc: acc}) do
    receive do
      :exit ->
        :nop

      {sender_pid, :next_state} ->
        next_state(state)
        |> case do
          :finished ->
            send(sender_pid, {:finished, acc})
            send(self(), :exit)
            loop(state)

          state ->
            send(sender_pid, state)
            loop(state)
        end
    end
  end

  def next_state(state = %{instructions: instructions, curr: curr, acc: acc}) do
    Enum.fetch(instructions, curr)
    |> case do
      {:ok, current_instruction} ->
        {to_jmp, to_add} = execute_instruction(current_instruction)
        %{state | curr: curr + to_jmp, acc: acc + to_add}

      :error ->
        :finished
    end
  end

  def execute_instruction({:nop, _val}), do: {1, 0}
  def execute_instruction({:jmp, val}), do: {val, 0}
  def execute_instruction({:acc, val}), do: {1, val}

  def p2 do
    get_instructions()
    |> find_not_looping_acc()
  end

  def find_not_looping_acc(instructions) do
    len = length(instructions)

    0..len
    |> Enum.find_value(fn idx ->
      permute(instructions, idx)
      |> get_result()
    end)
  end

  def permute(instructions, idx) do
    case Enum.at(instructions, idx) do
      {:jmp, val} -> List.update_at(instructions, idx, fn _ -> {:nop, val} end)
      {:nop, val} -> List.update_at(instructions, idx, fn _ -> {:jmp, val} end)
      {_, _} -> nil
    end
  end

  def get_result(nil) do
    nil
  end

  def get_result(instruction_list) do
    get_acc_on_end_or_loop(spawn_handheld(instruction_list))
    |> case do
      {:looping, _} -> nil
      {:notlooping, acc} -> acc
    end
  end
end
