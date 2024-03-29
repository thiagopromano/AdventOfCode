import AOC

aoc 2021, 1 do
  def input_string_test do
    """
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
    """
  end

  def p1 do
    get_input()
    |> MathTools.conv([1, -1])
    |> Enum.count(&Kernel.>(&1, 0))
  end

  def p2 do
    get_input()
    |> MathTools.conv([1, 0, 0, -1])
    |> Enum.count(&Kernel.>(&1, 0))
  end
  def get_input do
    input_string()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

end
