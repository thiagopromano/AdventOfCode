defmodule Y2021.D7Test do
  use ExUnit.Case
  require InputHelper
  alias Y2021.D7
  InputHelper.setup("16,1,2,0,4,2,7,1,2,14")

  test "p1" do
    assert D7.p1() == 37
  end

  test "p2" do
    assert D7.p2() == 168
  end
end
