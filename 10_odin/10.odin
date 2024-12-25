package main

import "core:fmt"
import "core:os"
import "core:strings"

Direction :: struct {
    dx: int, dy: int,
}

// Define the four possible directions
directions := [4]Direction{ { dx = 0, dy = -1 }, { dx = -1, dy = 0 }, { dx = 1, dy = 0 }, { dx = 0, dy = 1 }, }

trace :: proc(ss: []string, i: int, j: int, prev: u8, level: bool, visited: ^map[[2]int]bool) -> int {
    if i < 0 || i >= len(ss) || j < 0 || j >= len(ss[i]) || ss[i][j] != prev + 1 && prev != 42 {
        return 0
    }
    if ss[i][j] == '9' {
        visited[[2]int{ i, j }] = true
        return 1
    }
    total := 0
    for dir in directions {
        total += trace(ss, i + dir.dx, j + dir.dy, ss[i][j], level, visited)
    }
    return total
}

main :: proc() {
    run_level(false)
    run_level(true)
}

run_level :: proc(level: bool) {
    if data, ok := os.read_entire_file("10.in"); !ok {
        fmt.println("Failed to read file")
    } else {
        total := 0
        ss := strings.split(string(data), "\n")
        for i in 0 ..< len(ss) {
            for j in 0 ..< len(ss[i]) {
                if ss[i][j] == '0' {
                    visited := make(map[[2]int]bool)
                    res := trace(ss, i, j, 42, level, &visited)
                    total += res if level else len(visited)
                }
            }
        }
        fmt.println(total)
    }
}