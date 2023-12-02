defmodule Y2021.D15Test do
  use ExUnit.Case
  require InputHelper
  alias Y2021.D15

  InputHelper.setup("""
  1163751742
  1381373672
  2136511328
  3694931569
  7463417111
  1319128137
  1359912421
  3125421639
  1293138521
  2311944581
  """)

  test "p1" do
    assert D15.p1() == 40
  end

  test "p2" do
    assert D15.p2() == 315
  end
end
