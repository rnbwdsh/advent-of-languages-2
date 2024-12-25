#!/usr/bin/awk -f03.in

BEGIN {sum = 0} {
    while (match($0, /mul\(([0-9]{1,3}),([0-9]{1,3})\)/, arr)) {
        sum += arr[1] * arr[2]
        $0 = substr($0, RSTART + RLENGTH)
    }
    print sum
}