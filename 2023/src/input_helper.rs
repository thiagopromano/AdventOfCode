pub mod input_helper {
    use std::fs::File;
    use std::io::prelude::*;
    use std::io::Read;
    use reqwest::blocking::Client;

    pub fn get_input(day: u32) -> String {
        let file = File::open(format!("input/day{}.txt", day));

        match file {
            Ok(mut file) => {
                let mut input = String::new();
                file.read_to_string(&mut input).unwrap();
                input
            }
            Err(_) => {
                let session = include_str!("../session.txt");

                let input = Client::new()
                    .get(format!("https://adventofcode.com/2023/day/{}/input", day))
                    .header("Cookie", format!("session={}", session.trim()))
                    .send()
                    .unwrap()
                    .text()
                    .unwrap();

                File::create(format!("input/day{}.txt", day))
                    .unwrap()
                    .write_all(input.as_bytes())
                    .unwrap();

                input
            }
        }
    }
}