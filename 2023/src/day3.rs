pub mod day3 {
    use std::collections::{HashMap, HashSet};

    pub fn p1(input: String) -> String {
        parse_schematic(input.trim().to_string())
            .iter()
            .sum::<u32>()
            .to_string()
    }

    fn parse_schematic(input: String) -> Vec<u32> {
        let mut map: HashSet<(i32, i32)> = HashSet::new();
        for (y, line) in input.lines().enumerate() {
            for (x, c) in line.chars().enumerate() {
                if c != '.' && !c.is_numeric() {
                    map.insert((x as i32, y as i32));
                }
            }
        }

        let mut numbers = Vec::new();
        for (y, line) in input.lines().enumerate() {
            let mut x = 0;
            while x < line.len() {
                if line.chars().nth(x).unwrap().is_numeric() {
                    let mut is_part_number = false;
                    let mut number = String::new();
                    while x < line.len() && line.chars().nth(x).unwrap().is_numeric() {
                        is_part_number =
                            is_part_number ||
                                map.contains(&(x as i32, y as i32 + 1)) ||
                                map.contains(&(x as i32, y as i32 - 1)) ||
                                map.contains(&(x as i32 + 1, y as i32)) ||
                                map.contains(&(x as i32 - 1, y as i32)) ||
                                map.contains(&(x as i32 + 1, y as i32 + 1)) ||
                                map.contains(&(x as i32 - 1, y as i32 - 1)) ||
                                map.contains(&(x as i32 + 1, y as i32 - 1)) ||
                                map.contains(&(x as i32 - 1, y as i32 + 1));
                        number.push(line.chars().nth(x).unwrap());
                        x += 1;
                    }
                    if is_part_number {
                        numbers.push(number.parse::<u32>().unwrap());
                    }
                }
                x += 1;
            }
        }

        numbers
    }

    pub fn p2(input: String) -> String {
        parse_schematic2(input.trim().to_string())
            .iter()
            .sum::<i32>()
            .to_string()
    }

    fn parse_schematic2(input: String) -> Vec<i32> {
        let mut map: HashMap<(i32, i32), Vec<i32>> = HashMap::new();
        for (y, line) in input.lines().enumerate() {
            for (x, c) in line.chars().enumerate() {
                if c == '*' {
                    map.insert((x as i32, y as i32), Vec::new());
                }
            }
        }

        for (y, line) in input.lines().enumerate() {
            let mut x = 0;
            while x < line.len() {
                if line.chars().nth(x).unwrap().is_numeric() {
                    let mut gear_location = Option::None;
                    let mut number = String::new();
                    while x < line.len() && line.chars().nth(x).unwrap().is_numeric() {
                        vec!((-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1))
                            .iter()
                            .for_each(|(dx, dy)| {
                                if map.contains_key(&(x as i32 + dx, y as i32 + dy)) {
                                    gear_location = Some((x as i32 + dx, y as i32 + dy));
                                }
                            });
                        number.push(line.chars().nth(x).unwrap());
                        x += 1;
                    }
                    match gear_location {
                        Some(gear_location) => {
                            map.get_mut(&gear_location).unwrap().push(number.parse::<i32>().unwrap());
                        }
                        None => {}
                    }
                }
                x += 1;
            }
        }

        map
            .values()
            .filter(|v| v.len() == 2)
            .map(|v| v.iter().product::<i32>())
            .collect()
    }


    #[cfg(test)]
    mod tests {
        use super::*;


        #[test]
        fn day3_example1() {
            let example =
                "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..";
            assert_eq!(p1(example.to_string()), "4361");
        }

        #[test]
        fn day3_part1() {
            let input = include_str!("../input/day3.txt");
            assert_eq!(p1(input.to_string()), "543867");
        }

        #[test]
        fn day3_example2() {
            let example = "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..";
            assert_eq!(p2(example.to_string()), "467835");
        }

        #[test]
        fn day3_part2() {
            let input = include_str!("../input/day3.txt");
            assert_eq!(p2(input.to_string()), "72422");
        }
    }
}