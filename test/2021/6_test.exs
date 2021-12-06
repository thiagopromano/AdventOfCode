defmodule AdventTest20216 do
  use ExUnit.Case
  require InputHelper
  alias Y2021.D6
  InputHelper.setup("3,4,3,1,2")

  test "p1" do
      assert D6.p1() == 5934
  end
  test "p2" do
      assert D6.p2() == 26_984_457_539
  end
end
