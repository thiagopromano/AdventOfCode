pub mod day2 {
    use regex::Regex;

    pub fn p1(input: String) -> String {
        input
            .trim()
            .split("\n")
            .map(|line| parse_game(line))
            .filter(|game| game.presentations.iter().all(|presentation| !(presentation.red > 12 || presentation.green > 13 || presentation.blue > 14)))
            .map(|game| game.game_number)
            .sum::<u32>()
            .to_string()
    }


    pub fn p2(input: String) -> String {
        input
            .trim()
            .split("\n")
            .map(|line| parse_game(line))
            .map(|game| get_power(game))
            .sum::<u32>()
            .to_string()
    }

    fn get_power(game: Game) -> u32 {
        let max_green = game.presentations.iter().map(|presentation| presentation.green).max().unwrap();
        let max_red = game.presentations.iter().map(|presentation| presentation.red).max().unwrap();
        let max_blue = game.presentations.iter().map(|presentation| presentation.blue).max().unwrap();

        max_green * max_red * max_blue
    }

    #[derive(PartialEq)]
    #[derive(Debug)]
    pub struct CubeGameCount {
        green: u32,
        red: u32,
        blue: u32,
    }

    #[derive(PartialEq)]
    #[derive(Debug)]
    pub struct Game {
        game_number: u32,
        presentations: Vec<CubeGameCount>,
    }

    pub fn parse_game(line: &str) -> Game {
        let re = Regex::new(r"^Game (\d+): (.+)$").unwrap();
        let captures = re.captures(line).unwrap();

        let game_number = captures.get(1).unwrap().as_str().parse::<u32>().unwrap();
        let presentations = captures.get(2).unwrap().as_str();

        let presentations = presentations
            .split(";")
            .map(|presentation| parse_presentation(presentation))
            .collect();

        Game {
            game_number,
            presentations,
        }
    }

    fn parse_presentation(presentation: &str) -> CubeGameCount {
        let re = Regex::new(r"(\d+) green").unwrap();
        let captures = re.captures(presentation);
        let green = match captures {
            None => {
                0
            }
            Some(captures) => {
                captures.get(1).unwrap().as_str().parse::<u32>().unwrap()
            }
        };

        let re = Regex::new(r"(\d+) red").unwrap();
        let captures = re.captures(presentation);
        let red = match captures {
            None => {
                0
            }
            Some(captures) => {
                captures.get(1).unwrap().as_str().parse::<u32>().unwrap()
            }
        };

        let re = Regex::new(r"(\d+) blue").unwrap();
        let captures = re.captures(presentation);
        let blue = match captures {
            None => {
                0
            }
            Some(captures) => {
                captures.get(1).unwrap().as_str().parse::<u32>().unwrap()
            }
        };
        CubeGameCount {
            green,
            red,
            blue,
        }
    }


    #[cfg(test)]
    mod tests {
        use super::*;

        #[test]
        fn parse_game_test() {
            let game = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red";

            assert_eq!(parse_game(game), Game {
                game_number: 3,
                presentations: vec![
                    CubeGameCount {
                        green: 8,
                        red: 20,
                        blue: 6,
                    },
                    CubeGameCount {
                        green: 13,
                        red: 4,
                        blue: 5,
                    },
                    CubeGameCount {
                        green: 5,
                        red: 1,
                        blue: 0,
                    },
                ],
            })
        }
    }

    #[test]
    fn day2_example1() {
        let example =
            "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";
        assert_eq!(p1(example.to_string()), "8");
    }

    #[test]
    fn day2_part1() {
        let input = include_str!("../input/day2.txt");
        assert_eq!(p1(input.to_string()), "2105");
    }

    #[test]
    fn day2_example2() {
        let example = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";
        assert_eq!(p2(example.to_string()), "2286");
    }

    #[test]
    fn day2_part2() {
        let input = include_str!("../input/day2.txt");
        assert_eq!(p2(input.to_string()), "72422");
    }
}