import AOC

aoc 2021, 11 do
  use InputHelper

  def directions(),
    do: [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]

  def get_input do
    input_string()
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(fn line -> line |> Enum.map(&(&1 - ?0)) end)
    |> MapTools.to_2d_map()
  end

  def p1 do
    get_input()
    |> stepp1(100)
  end

  def stepp1(map, count), do: step(map, 0, count)
  def step(_map, flashed_times, 0), do: flashed_times

  def step(map, flashed_times, times) do
    {updated_map, flashed_times_in_iteration} = update_map(map)
    step(updated_map, flashed_times + flashed_times_in_iteration, times - 1)
  end

  def update_map(map) do
    # start by adding 1 to all positions
    updated_map =
      Enum.reduce(map, map, fn {pos, _}, acc_map ->
        Map.update!(acc_map, pos, &(&1 + 1))
      end)

    positions_that_will_flash = find_all_flashing_positions(updated_map)

    {updated_map, flashed_times_iteration} =
      chain_reaction(
        updated_map,
        MapSet.new(positions_that_will_flash),
        positions_that_will_flash
      )

    {updated_map, flashed_times_iteration}
  end

  def find_all_flashing_positions(map),
    do: Enum.filter(map, fn {_, val} -> val > 9 end) |> Enum.map(&elem(&1, 0))

  def reset_exploded_positions(map, flashed_positions) do
    flashed_positions
    |> Enum.reduce(map, fn pos, map -> Map.replace!(map, pos, 0) end)
  end

  def chain_reaction(map, flashed_positions_set, []),
    do: {reset_exploded_positions(map, flashed_positions_set), MapSet.size(flashed_positions_set)}

  def chain_reaction(map, flashed_positions_set, [position_checking | positions_that_will_flash]) do
    {updated_map, flashed_positions_set, positions_that_will_flash} =
      directions()
      |> Enum.reduce({map, flashed_positions_set, positions_that_will_flash}, fn direction,
                                                                                 {map,
                                                                                  flashed_positions_set,
                                                                                  positions_that_will_flash} ->
        pos = MapTools.point_sum(direction, position_checking)

        Map.get(map, pos, :out_of_bounds)
        |> case do
          :out_of_bounds ->
            {map, flashed_positions_set, positions_that_will_flash}

          val when val < 9 ->
            {Map.update!(map, pos, &(&1 + 1)), flashed_positions_set, positions_that_will_flash}

          val when val >= 9 ->
            if MapSet.member?(flashed_positions_set, pos) do
              {Map.update!(map, pos, &(&1 + 1)), flashed_positions_set, positions_that_will_flash}
            else
              {Map.update!(map, pos, &(&1 + 1)), MapSet.put(flashed_positions_set, pos),
               [pos] ++ positions_that_will_flash}
            end
        end
      end)

    chain_reaction(updated_map, flashed_positions_set, positions_that_will_flash)
  end

  def p2 do
    get_input()
    |> find_sync_step(0)
  end

  def find_sync_step(map, count) do
    {updated_map, flashed_times_in_iteration} = update_map(map)

    case flashed_times_in_iteration do
      100 -> count + 1
      _ -> find_sync_step(updated_map, count + 1)
    end
  end
end
