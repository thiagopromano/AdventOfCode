defmodule Y2021.D16Test do
  use ExUnit.Case
  require InputHelper
  alias Y2021.D16

  test "Literal" do
    assert D16.decode_packet_str("D2FE28") ==
             {%{type: :literal, version: 6, val: 2021}, <<0::size(3)>>}
  end

  test "Operator Length ID 0" do
    assert D16.decode_packet_str("38006F45291200") ==
             {%{
                subpackets: [
                  %{type: :literal, val: 10, version: 6},
                  %{type: :literal, val: 20, version: 2}
                ],
                type: 6,
                version: 1
              }, <<0::size(7)>>}
  end

  test "Operator Length ID 1" do
    assert D16.decode_packet_str("EE00D40C823060") ==
             {%{
                subpackets: [
                  %{type: :literal, val: 1, version: 2},
                  %{type: :literal, val: 2, version: 4},
                  %{type: :literal, val: 3, version: 1}
                ],
                type: 3,
                version: 7
              }, <<0::size(5)>>}
  end

  test "p1" do
    InputHelper.set_input_string("""
    A0016C880162017C3686B18A3D4780
    """)

    assert D16.p1() == 31
  end

  test "p2" do
    InputHelper.set_input_string("""
    9C0141080250320F1802104A08
    """)

    assert D16.p2() == 1
  end
end
