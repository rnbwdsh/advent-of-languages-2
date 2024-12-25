// compile + run with go build -gcflags="-B" -o 09 09.go; time ./09
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

const (
    LEVEL = 0
	FREE    = -1
	BUF_SIZE = 100000
)

func defrag1(a []int, lpos, pos int) {
	for pos >= lpos {
		for a[pos] == FREE {
			pos--
			if pos < 0 {
				break
			}
		}
		for a[lpos] != FREE {
			lpos++
		}
		if pos >= lpos {
			a[pos], a[lpos] = a[lpos], a[pos]
		}
		pos--
		lpos++
	}
}

func defrag2(a []int, curr int, fileSize, fileStart []int) {
	for fileID := curr / 2; fileID > 0; fileID-- {
		start := fileStart[fileID]
		size := fileSize[fileID]
		offset := 0
		found := false
		for offset < start {
			pos := 0
			for pos < size && offset+pos < start && a[offset+pos] == FREE {
				pos++
			}
			if pos == size {
				found = true
				break
			}
			offset += pos + 1
		}
		if found {
			for i := 0; i < size; i++ {
				a[offset+i] = fileID
				a[start+i] = FREE
			}
		}
	}
}

func checksum(a []int) int {
	total := 0
	for i := 0; i < BUF_SIZE; i++ {
		if a[i] != FREE {
			total += i * a[i]
		}
	}
	return total
}

func main() {
    for level := 0; level < 2; level++ {
        file, err := os.Open("09.in")
        if err != nil {
            fmt.Println("Error opening file:", err)
            return
        }
        defer file.Close()

        scanner := bufio.NewScanner(file)
        scanner.Scan()
        data := scanner.Text()

        a := make([]int, BUF_SIZE)
        for i := range a {
            a[i] = FREE
        }

        curr := 0
        pos := 0
        var fileSize []int
        var fileStart []int

        for _, c := range strings.Split(data, "") {
            cInt, _ := strconv.Atoi(c)
            for i := 0; i < cInt; i++ {
                if curr%2 == 0 {
                    a[pos+i] = curr / 2
                } else {
                    a[pos+i] = FREE
                }
            }
            if curr%2 == 0 {
                fileSize = append(fileSize, cInt)
                fileStart = append(fileStart, pos)
            }
            pos += cInt
            curr++
        }

        // reorder stuff
        if level == 0 {
            defrag1(a, int(data[0]-'0'), pos)
        } else {
            defrag2(a, curr, fileSize, fileStart)
        }

        fmt.Println(checksum(a))
	}
}