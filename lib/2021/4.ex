import AOC

aoc 2021, 4 do
  def input_string_test do
    """
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
    8  2 23  4 24
    21  9 14 16  7
    6 10  3 18  5
    1 12 20 15 19

    3 15  0  2 22
    9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
    2  0 12  3  7
    """
  end

  def get_input do
    [sequence | games] =
      input_string()
      |> String.trim()
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))

    sequence = sequence |> String.split(",") |> array_of_numbers
    games = games |> Enum.map(&format_games/1) |> Enum.chunk_every(5)

    {sequence, games}
  end

  def array_of_numbers(array), do: array |> Enum.map(&String.to_integer/1)
  def format_games(game_str), do: String.split(game_str) |> array_of_numbers

  def add_tranpose(games), do: games |> Enum.map(fn row -> row ++ MathTools.transpose(row) end)

  def p1 do
    {sequence, games} = get_input()

    games_with_transpose = add_tranpose(games)

    {final_call, game} = play_bingo(sequence, games_with_transpose)

    sum =
      game
      |> Enum.take(5)
      |> List.flatten()
      |> Enum.sum()

    final_call * sum
  end

  def play_bingo(sequence, games) do
    [next_number | tail_sequence] = sequence
    games = update_games(next_number, games)

    if winning_game = winning_game(games) do
      {next_number, Enum.fetch!(games, winning_game)}
    else
      play_bingo(tail_sequence, games)
    end
  end

  def winning_game(games) do
    games
    |> Enum.find_index(fn game -> Enum.any?(game, &Enum.empty?/1) end)
  end

  def update_games(number, games) do
    Enum.map(games, fn game ->
      Enum.map(game, fn line -> Enum.reject(line, &(&1 == number)) end)
    end)
  end

  def p2 do
    {sequence, games} = get_input()
    games_with_transpose = add_tranpose(games)

    {final_call, game} = play_bingo_last(sequence, games_with_transpose)

    sum =
      game
      |> Enum.take(5)
      |> List.flatten()
      |> Enum.sum()

    final_call * sum
  end

  def play_bingo_last(sequence, games) do
    [next_number | tail_sequence] = sequence
    games = update_games(next_number, games)

    if winning_game = winning_game(games) do
      if length(games) == 1 do
        {next_number, Enum.fetch!(games, winning_game)}
      else
        games = games |> Enum.reject(fn game -> Enum.any?(game, &Enum.empty?/1) end)
        play_bingo_last(tail_sequence, games)
      end
    else
      play_bingo_last(tail_sequence, games)
    end
  end
end
