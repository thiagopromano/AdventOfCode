defmodule Y2021.D11Test do
  use ExUnit.Case
  require InputHelper
  alias Y2021.D11

  InputHelper.setup("""
  5483143223
  2745854711
  5264556173
  6141336146
  6357385478
  4167524645
  2176841721
  6882881134
  4846848554
  5283751526
  """)

  test "p1" do
    assert D11.p1() == 1_656
  end

  test "p2" do
    assert D11.p2() == 195
  end
end
