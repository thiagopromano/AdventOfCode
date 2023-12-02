import AOC

aoc 2021, 7 do
  use InputHelper

  def get_input do
    input_string()
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def p1 do
    input = get_input()
    {min, max} = Enum.min_max(input)

    min..max
    |> Enum.min_by(&calculate_cost_to_move_all_crabs_to_position(input, &1))
    |> then(&calculate_cost_to_move_all_crabs_to_position(input, &1))
  end

  defp calculate_cost_to_move_all_crabs_to_position(original_positions, final_position) do
    original_positions
    |> Enum.map(&abs(&1 - final_position))
    |> Enum.sum()
  end

  def p2 do
    input = get_input()
    {min, max} = Enum.min_max(input)

    min..max
    |> Enum.min_by(&calculate_cost_to_move_all_crabs_to_position_increasing(input, &1))
    |> then(&calculate_cost_to_move_all_crabs_to_position_increasing(input, &1))
  end

  defp calculate_cost_to_move_all_crabs_to_position_increasing(original_positions, final_position) do
    original_positions
    |> Enum.map(&MathTools.arithmetic_series_sum(1, abs(&1 - final_position)))
    |> Enum.sum()
  end
end
