defmodule Y2021.D12Test do
  use ExUnit.Case
  require InputHelper
  alias Y2021.D12

  InputHelper.setup("""
  fs-end
  he-DX
  fs-he
  start-DX
  pj-DX
  end-zg
  zg-sl
  zg-pj
  pj-he
  RW-he
  fs-DX
  pj-RW
  zg-RW
  start-pj
  he-WI
  zg-he
  pj-fs
  start-RW
  """)

  test "p1" do
    assert D12.p1() == 226
  end

  test "p2" do
    assert D12.p2() == 3_509
  end
end
