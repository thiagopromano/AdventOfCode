defmodule Y2021.D9Test do
  use ExUnit.Case
  require InputHelper
  alias Y2021.D9

  InputHelper.setup("""
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
  """)

  test "p1" do
    assert D9.p1() == 15
  end

  test "p2" do
    assert D9.p2() == 1_134
  end
end
