#include <cstdint>
#include <iostream>
#include <array>

constexpr std::array<int, 16> expected_values = {2, 4, 1, 5, 7, 5, 0, 3, 4, 0, 1, 6, 5, 5, 3, 0};
constexpr int shift = 12;
uint64_t bestA = 0;
int bestOutput = -1;


// extracted, unrolled program 2,4,1,5,7,5,0,3,4,0,1,6,5,5,3,0 that exits early if the print doesn't match the program
int program(uint64_t ao, bool print = false)
{
    uint64_t a, b, c;
    b = c = 0;
    a = ao;
    for (int i = 0; i < expected_values.size(); ++i) {
        b = a & 7;
        b ^= 5;
        c = a >> b;
        a = a >> 3;
        b = b ^ c;
        b ^= 6;
        if (print) {
            std::cout << (b % 8) << ",";
            if (a == 0)
                return 0;
        }
        else if ((b & 7) != expected_values[i])
            return i;  // Return the index (1-based) if the condition fails
    }
    return 16;
}

void recursiveSearch(uint64_t a, int lastOutput, int depth = 0) {
    for (uint64_t b = 0; b < (1 << shift); ++b) {
        uint64_t aNew = a | (b << (shift*depth));
        int currentOutput = program(aNew, false);
        if (currentOutput > lastOutput) {
            if (currentOutput > bestOutput || (currentOutput == bestOutput && aNew < bestA)) {
                bestOutput = currentOutput;
                bestA = aNew;
            }
            recursiveSearch(aNew, currentOutput, depth+1);
        }
    }
}

int main() {
    program(46187030ULL, true);
    std::cout << std::endl;
    recursiveSearch(0, 0, 0);
    std::cout << std::oct << bestA << std::endl;
    return 0;
}
