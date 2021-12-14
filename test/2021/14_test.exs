defmodule Y2021.D14Test do
  use ExUnit.Case
  require InputHelper
  alias Y2021.D14

  InputHelper.setup("""
  NNCB

  CH -> B
  HH -> N
  CB -> H
  NH -> C
  HB -> C
  HC -> B
  HN -> C
  NN -> C
  BH -> H
  NC -> B
  NB -> B
  BN -> B
  BB -> N
  BC -> B
  CC -> N
  CN -> C
  """)

  test "p1" do
    assert D14.p1() == 1_588
  end

  test "p2" do
    assert D14.p2() == 2_188_189_693_529
  end
end
