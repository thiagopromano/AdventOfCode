pub mod day2 {
    pub fn p1(input: String) -> String {

    }


    pub fn p2(input: String) -> String {

    }

    fn parse_line_p2(line: &str) -> u32 {

    }
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn day1_example1() {
        let example =
            "1abc2\n\
pqr3stu8vwx\n\
a1b2c3d4e5f\n\
treb7uchet\n";
        assert_eq!(day1::p1(example.to_string()), "142");
    }

    #[test]
    fn day1_part1() {
        let input = include_str!("../input/day1.txt");
        assert_eq!(day1::p1(input.to_string()), "56506");
    }

    #[test]
    fn day1_example2() {
        let example =
            "two1nine\n\
eightwothree\n\
abcone2threexyz\n\
xtwone3four\n\
4nineeightseven2\n\
zoneight234\n\
7pqrstsixteen\n\
";
        assert_eq!(day1::p2(example.to_string()), "281");
    }

    #[test]
    fn day1_part2() {
        let input = include_str!("../input/day1.txt");
        assert_eq!(day1::p2(input.to_string()), "56017");
    }
}