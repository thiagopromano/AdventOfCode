import AOC

aoc 2021, 16 do
  use InputHelper

  def decode_packet_str(hex_str) do
    Base.decode16!(hex_str)
    |> decode_packet
  end

  # Literal
  def decode_packet(<<version::3, 4::3, val::bits>>) do
    {number, remainder} = decode_literal_val(<<>>, val)
    number_size = bit_size(number)
    <<n::integer-size(number_size)>> = number
    {%{version: version, type: :literal, val: n}, remainder}
  end


  # Operator With Length Type ID 0
  def decode_packet(<<version::3, type::3, 0::1, length::15, rest::bits>>) do
    <<this_packet_data::bits-size(length), remainder::bits>> = rest

    inside_packets = decode_subpackets_until_empty(this_packet_data)
    {%{version: version, type: type, subpackets: inside_packets}, remainder}
  end

  # Operator With Length Type ID 1
  def decode_packet(<<version::3, type::3, 1::1, number_of_subpackets::11, next_bits::bits>>) do
    {inside_packets, remainder} = decode_subpackets_amount(next_bits, number_of_subpackets)
    {%{version: version, type: type, subpackets: inside_packets}, remainder}
  end

  def decode_subpackets_until_empty(<<>>), do: []

  def decode_subpackets_until_empty(packet_data) do
    {packet, rem} = decode_packet(packet_data)
    [packet] ++ decode_subpackets_until_empty(rem)
  end

  def decode_subpackets_amount(packet_data, subpacket_count),
    do: decode_subpackets_amount([], packet_data, subpacket_count)

  def decode_subpackets_amount(acc, rem, 0), do: {Enum.reverse(acc), rem}

  def decode_subpackets_amount(acc, packet_data, subpacket_count) do
    {packet, rem} = decode_packet(packet_data)
    decode_subpackets_amount([packet] ++ acc, rem, subpacket_count - 1)
  end

  def sum_versions(%{version: version, type: :literal}), do: version

  def sum_versions(%{version: version, subpackets: subpackets}),
    do: version + Enum.sum(Enum.map(subpackets, &sum_versions/1))

  def p1 do
    {packet, _} = decode_packet_str(input_string() |> String.trim())
    sum_versions(packet)
  end

  def p2 do
    {packet, _} = decode_packet_str(input_string() |> String.trim())
    get_value(packet)
  end

  def get_value(%{type: :literal, val: val}), do: val
  # Sum
  def get_value(%{type: 0, subpackets: subpackets}) do
    Enum.map(subpackets, &get_value/1)
    |> Enum.sum()
  end

  # Product
  def get_value(%{type: 1, subpackets: subpackets}) do
    Enum.map(subpackets, &get_value/1)
    |> Enum.product()
  end

  # Minimum
  def get_value(%{type: 2, subpackets: subpackets}) do
    Enum.map(subpackets, &get_value/1)
    |> Enum.min()
  end

  # Maximum
  def get_value(%{type: 3, subpackets: subpackets}) do
    Enum.map(subpackets, &get_value/1)
    |> Enum.max()
  end

  # Greather Than
  def get_value(%{type: 5, subpackets: subpackets}) do
    [a, b] = Enum.map(subpackets, &get_value/1)
    if a > b, do: 1, else: 0
  end

  # Lower Than
  def get_value(%{type: 6, subpackets: subpackets}) do
    [a, b] = Enum.map(subpackets, &get_value/1)
    if a < b, do: 1, else: 0
  end

  # Equal To
  def get_value(%{type: 7, subpackets: subpackets}) do
    [a, b] = Enum.map(subpackets, &get_value/1)
    if a == b, do: 1, else: 0
  end

  def decode_literal_val(preceding, <<1::integer-size(1), data::bits-size(4), rest::bits>>),
    do: <<preceding::bitstring, data::bitstring>> |> decode_literal_val(rest)

  def decode_literal_val(preceding, <<0::integer-size(1), data::bits-size(4), rest::bits>>),
    do: {<<preceding::bitstring, data::bitstring>>, rest}
end
