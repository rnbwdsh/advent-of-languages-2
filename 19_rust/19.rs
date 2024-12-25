use std::fs::read_to_string;
use std::collections::HashMap;

fn can_make(pattern: &str, available: &[&str]) -> bool {
    pattern.is_empty() || available.iter().any(|&x|
        pattern.starts_with(x) && can_make(&pattern[x.len()..], available))
}

fn can_make_number(pattern: &str, available: &[&str], cache: &mut HashMap<String, usize>) -> usize {
    match cache.get(pattern) {
        Some(&result) => result,
        None => {
            let result = available.iter().filter(|&x| pattern.starts_with(x))
                .map(|&x| can_make_number(&pattern[x.len()..], available, cache)).sum();
            cache.insert(pattern.to_string(), result);
            result
        }
    }
}

fn main() {
    let fc = read_to_string("19.in").expect("Cannot read file");
    let input = fc.split("\n\n").collect::<Vec<&str>>();
    let available: Vec<&str> = input[0].split(", ").collect();
    let lines = input[1].split("\n").collect::<Vec<&str>>();
    let total: usize = lines.iter().map(|combination| can_make(combination, &available) as usize).sum();
    println!("{:?}", total);
    let mut cache: HashMap<String, usize> = HashMap::new();
    cache.insert("".to_string(), 1);
    let total_make: usize = lines.iter().map(|pattern| can_make_number(pattern, &available, &mut cache)).sum();
    println!("{:?}", total_make);
}