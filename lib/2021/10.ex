import AOC

aoc 2021, 10 do
  use InputHelper

  @opening_chars [?(, ?[, ?{, ?<]
  @closing_chars [?), ?], ?}, ?>]
  @respective_closing Enum.zip(@closing_chars, @opening_chars) |> Map.new()
  @scoring_p1 Enum.zip(@closing_chars, [3, 57, 1197, 25_137]) |> Map.new()
  @scoring_p2 Enum.zip(@opening_chars, 1..4) |> Map.new()

  def get_input do
    input_string()
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  def p1 do
    get_input()
    |> Enum.map(&apply_rules/1)
    |> Enum.map(&calculate_p1_score/1)
    |> Enum.sum()
  end

  def calculate_p1_score({:illegal, closing_char}), do: Map.fetch!(@scoring_p1, closing_char)
  def calculate_p1_score(_), do: 0

  def apply_rules(line), do: apply_rules(line, [])
  def apply_rules([], []), do: :ok
  def apply_rules([], non_closed), do: {:non_closed, non_closed}

  def apply_rules([input_head | input_tail], stack) do
    cond do
      input_head in @opening_chars ->
        apply_rules(input_tail, [input_head] ++ stack)

      input_head in @closing_chars ->
        respective = Map.fetch!(@respective_closing, input_head)

        case hd(stack) do
          ^respective -> apply_rules(input_tail, tl(stack))
          _ -> {:illegal, input_head}
        end
    end
  end

  def p2 do
    scores = get_input()
    |> Enum.map(&apply_rules/1)
    |> Enum.map(&calculate_p2_score/1)
    |> Enum.filter(&(&1 != 0))
    |> Enum.sort()

    Enum.fetch!(scores, floor(length(scores) / 2))
  end

  def calculate_p2_score({:non_closed, non_closed_sequence}) do
    non_closed_sequence
    |> Enum.map(&(Map.fetch!(@scoring_p2, &1)))
    |> Enum.reduce(0, fn score, total_score -> total_score * 5 + score end)
  end

  def calculate_p2_score(_), do: 0
end
