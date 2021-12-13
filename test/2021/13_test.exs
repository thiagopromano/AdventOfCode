defmodule Y2021.D13Test do
  use ExUnit.Case
  require InputHelper
  alias Y2021.D13

  InputHelper.setup("""
  6,10
  0,14
  9,10
  0,3
  10,4
  4,11
  6,0
  6,12
  4,1
  0,13
  10,12
  3,4
  3,0
  8,4
  1,10
  2,14
  8,10
  9,0

  fold along y=7
  fold along x=5
  """)

  test "p1" do
    assert D13.p1() == 17
  end

  test "p2" do
    assert D13.p2() == """
           #####
           #...#
           #...#
           #...#
           #####
           .....
           .....
           """
  end
end
