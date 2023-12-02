defmodule MathToolsTest do
  use ExUnit.Case

  test "aritmetic sum works" do
    assert MathTools.arithmetic_series_sum(1, 1) == 1
    assert MathTools.arithmetic_series_sum(1, 2) == 1 + 2
    assert MathTools.arithmetic_series_sum(3, 5) == 3 + 4 + 5
    assert MathTools.arithmetic_series_sum(10, 5) == 5 + 6 + 7 + 8 + 9 + 10
  end
end
