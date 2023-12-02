pub mod day1 {
    pub fn p1(input: String) -> String {
        input.trim()
            .split("\n")
            .map(|line| parse_line_p1(line))
            .sum::<u32>()
            .to_string()
    }

    fn parse_line_p1(line: &str) -> u32 {
        let numbers = line.chars();
        let mut first_number: Option<char> = None;
        let mut last_number: Option<char> = None;
        for c in numbers {
            if c.is_numeric() {
                if first_number.is_none() {
                    first_number = Some(c)
                }
                last_number = Some(c)
            }
        }
        // concatenate first and last number
        let mut result = String::new();
        result.push(first_number.unwrap());
        result.push(last_number.unwrap());
        result.parse::<u32>().unwrap()
    }

    pub fn p2(input: String) -> String {
        input.trim()
            .split("\n")
            .map(|line| parse_line_p2(line))
            .sum::<u32>()
            .to_string()
    }

    fn parse_line_p2(line: &str) -> u32 {
        let formatted_line = line
            .replace("one", "one1one")
            .replace("two", "two2two")
            .replace("three", "three3three")
            .replace("four", "four4four")
            .replace("five", "five5five")
            .replace("six", "six6six")
            .replace("seven", "seven7seven")
            .replace("eight", "eight8eight")
            .replace("nine", "nine9nine")
            .replace("zero", "ten0ten");

        parse_line_p1(&formatted_line)
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