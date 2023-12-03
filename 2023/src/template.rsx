pub mod dayx {

    pub fn p1(input: String) -> String {

    }


    pub fn p2(input: String) -> String {

    }



    #[cfg(test)]
    mod tests {
        use super::*;



    #[test]
    fn dayx_example1() {
        let example =
            "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";
        assert_eq!(p1(example.to_string()), "8");
    }

    #[test]
    fn dayx_part1() {
        let input = include_str!("../input/dayx.txt");
        assert_eq!(p1(input.to_string()), "2105");
    }

    #[test]
    fn dayx_example2() {
        let example = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";
        assert_eq!(p2(example.to_string()), "2286");
    }

    #[test]
    fn dayx_part2() {
        let input = include_str!("../input/dayx.txt");
        assert_eq!(p2(input.to_string()), "72422");
    }
}
}