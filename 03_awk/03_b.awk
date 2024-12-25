#!/usr/bin/awk -f

BEGIN {
    sum = 0
    enabled = 1
    do_pattern = "do\\(\\)"
    dont_pattern = "don't\\(\\)"
    mul_pattern = "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)"
    combined_pattern = do_pattern "|" dont_pattern "|" mul_pattern
} {
    while (match($0, combined_pattern, arr)) {
        if (arr[0] ~ do_pattern) {
            enabled = 1
        } else if (arr[0] ~ dont_pattern) {
            enabled = 0
        } else if (enabled) {
            sum += arr[1] * arr[2]
        }
        $0 = substr($0, RSTART + RLENGTH)
    }
    print sum
}