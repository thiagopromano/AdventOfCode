defmodule Y2021.D10Test do
  use ExUnit.Case
  require InputHelper
  alias Y2021.D10

  InputHelper.setup("""
  [({(<(())[]>[[{[]{<()<>>
  [(()[<>])]({[<{<<[]>>(
  {([(<{}[<>[]}>{[]{[(<()>
  (((({<>}<{<{<>}{[]{[]{}
  [[<[([]))<([[{}[[()]]]
  [{[{({}]{}}([{[{{{}}([]
  {<[[]]>}<{[{[{[]{()[[[]
  [<(<(<(<{}))><([]([]()
  <{([([[(<>()){}]>(<<{{
  <{([{{}}[<[[[<>{}]]]>[]]
  """)

  test "p1" do
    assert D10.p1() == 26_397
  end

  test "p2" do
    assert D10.p2() == 288_957
  end
end
