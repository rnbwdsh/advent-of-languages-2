const fs = require('node:fs');

const pos_add = (a, b) => [a[0] + b[0], a[1] + b[1]];
const hamming = (a, b) => Math.abs(a[0] - b[0]) + Math.abs(a[1] - b[1]);
const adj = [[0, 1], [0, -1], [1, 0], [-1, 0]];

function find_shortcuts(sorted, max_dist, min_shortcut) {
    shortcuts = 0;
    for (let end = 0; end < sorted.length; end++) {
        for (let start = 0; start < end - max_dist; start++) {
            const dist = hamming(sorted[start], sorted[end]);
            if (dist <= max_dist && (end - start - dist >= min_shortcut))
                shortcuts++;
        }
    }
    return shortcuts;
}

function sorted_elements_of(start, end, path) {
    let curr = end;
    let dist = 0;
    while (curr.toString() !== start.toString()) {
        path[curr] = dist++;
        adj.map(a => pos_add(curr, a))
            .filter(next => path[next.toString()] === -1)
            .forEach(next => curr = next);
    }
    path[start] = dist;

    const sorted = Object.entries(path)
        .sort((a, b) => a[1] - b[1])
        .map(a => a[0].split(",").map(Number));
    return sorted;
}

function count_shortcuts(filename, max_dist, min_shortcut) {
    const path = {};
    let start, end;
    fs.readFileSync(filename, "utf8").split("\n").forEach((line, i) => {
        [...line].forEach((char, j) => {
            if (char === '#') return;
            if (char === 'S') start = [i, j];
            if (char === 'E') end = [i, j];
            path[[i, j].toString()] = -1;
        });
    });
    const sorted = sorted_elements_of(start, end, path);
    console.log(find_shortcuts(sorted, max_dist, min_shortcut));
}

// call with all combos of "20.example.in", "20.in", and the stuff you infer from above
count_shortcuts("20.example.in", 2, 1);
count_shortcuts("20.in", 2, 100);
count_shortcuts("20.example.in", 20, 50);
count_shortcuts("20.in", 20, 100);