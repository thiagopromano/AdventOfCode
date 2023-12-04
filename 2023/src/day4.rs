pub mod day4 {
    use regex::Regex;

    pub fn p1(input: String) -> String {
        input
            .trim()
            .split("\n")
            .map(|line| parse_card(line))
            .map(|game| calculate_score_p1(game))
            .sum::<u32>()
            .to_string()
    }


    pub fn p2(input: String) -> String {
        let games: Vec<Game> = input
            .trim()
            .split("\n")
            .map(|line| parse_card(line))
            .collect();

        let mut scratches = vec![1; games.len()];
        for i in 0..games.len() {
            let amount_wins = calculate_amount_wins(&games[i]) as usize;
            for n in 1..=amount_wins {
                scratches[i + n] += scratches[i];
            }
        }

        scratches.iter().sum::<u32>().to_string()
    }


    fn parse_card(line: &str) -> Game {
        let caps = Regex::new(r"^Card +(\d+): (.+) \| (.+)$").unwrap().captures(&line).unwrap();

        let game_number = caps.get(1).unwrap().as_str().parse::<u32>().unwrap();
        let winning_numbers = caps.get(2).unwrap().as_str().split_whitespace().map(|number| number.parse::<u32>().unwrap()).collect();
        let numbers = caps.get(3).unwrap().as_str().split_whitespace().map(|number| number.parse::<u32>().unwrap()).collect();

        Game {
            game_number,
            winning_numbers,
            numbers,
        }
    }

    fn calculate_score_p1(game: Game) -> u32 {
        let amount_wins = calculate_amount_wins(&game);
        if amount_wins == 0 {
            return 0;
        }

        2u32.pow(amount_wins - 1)
    }

    fn calculate_amount_wins(game: &Game) -> u32 {
        let mut amount_winning = 0;
        for number in &game.winning_numbers {
            if game.numbers.contains(&number) {
                amount_winning += 1;
            }
        }

        amount_winning
    }


    #[derive(PartialEq)]
    #[derive(Debug)]
    #[derive(Clone)]
    struct Game {
        game_number: u32,
        winning_numbers: Vec<u32>,
        numbers: Vec<u32>,
    }


    #[cfg(test)]
    mod tests {
        use super::*;
        use crate::input_helper::input_helper;

        #[test]
        fn day4_example1() {
            let example =
                "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11";
            assert_eq!(p1(example.to_string()), "13");
        }

        #[test]
        fn day4_part1() {
            assert_eq!(p1(input_helper::get_input(4)), "26426");
        }

        #[test]
        fn day4_example2() {
            let example = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11";
            assert_eq!(p2(example.to_string()), "30");
        }

        #[test]
        fn day4_part2() {
            assert_eq!(p2(input_helper::get_input(4)), "6227972");
        }
    }
}