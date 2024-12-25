#!/bin/bash
count=0

check_non_strict_order() {
    local nums=("$@")
    local non_strict_asc=true
    local non_strict_desc=true

    for (( i=0; i<${#nums[@]}-1; i++ )); do
        diff=$(( ${nums[i+1]} - ${nums[i]} ))
        if [ "$diff" -gt 3 ] || [ "$diff" -le 0 ]; then
            non_strict_asc=false
        fi
        if [ "$diff" -lt -3 ] || [ "$diff" -ge 0 ]; then
            non_strict_desc=false
        fi
    done

    if [ "$non_strict_asc" = true ] || [ "$non_strict_desc" = true ]; then
        return 0
    else
        return 1
    fi
}

while read -r line; do
    # Skip empty lines
    if [ -z "$line" ]; then
        continue
    fi

    read -ra nums <<< "$line"
    if check_non_strict_order "${nums[@]}"; then
        # echo "$line"
        ((count++))
    fi
done < 02.in

echo $count