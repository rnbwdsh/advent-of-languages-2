// compile and run with `gcc -o 06 06.c -O3; time ./06`
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define DIR_COUNT 4

// Direction lookup table: {dx, dy}
int DIR_LOOKUP[DIR_COUNT][2] = {
    {0, -1},  // Up
    {1, 0},   // Right
    {0, 1},   // Down
    {-1, 0}   // Left
};

int follow_path(char **data, int size, int posx, int posy, int max_steps, bool **seen) {
    int dir = 0;
    int steps = 0;
    for(; steps < max_steps; steps++) {
        if (seen != NULL) {
            seen[posx][posy] = true;
        }

        int nposx = posx + DIR_LOOKUP[dir][0];
        int nposy = posy + DIR_LOOKUP[dir][1];

        if (nposx < 0 || nposx >= size || nposy < 0 || nposy >= size) {
            break;
        }

        if (data[nposy][nposx] == '#') {
            dir = (dir + 1) % DIR_COUNT;  // Reverse direction
            continue;
        } else {
            posx = nposx;
            posy = nposy;
        }
    }
    // if seen is not null, return uniquely seen positions
    if(seen != NULL) {
        int total = 0;
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                if (seen[i][j]) {
                    total++;
                }
            }
        }
        return total;
    }

    return steps < max_steps ? (seen != NULL ? steps : 0) : -1;
}

int main() {
    FILE *file = fopen("06.in", "r");
    if (!file) {
        perror("Failed to open file");
        return 1;
    }

    char buffer[1024];
    fgets(buffer, sizeof(buffer), file);
    int size = 0;
    while (buffer[size] != '\0' && buffer[size] != '\n') {
        size++;
    }

    char **data = (char **)malloc(size * sizeof(char *));
    for (int i = 0; i < size; i++) {
        data[i] = (char *)malloc(size * sizeof(char));
    }

    // set first row
    for (int i = 0; i < size; i++) {
        data[0][i] = buffer[i];
    }

    int posx = -1, posy = -1;
    for (int i = 1; i < size; i++) {
        fgets(buffer, sizeof(buffer), file);
        for (int j = 0; j < size; j++) {
            data[i][j] = buffer[j];
            if (buffer[j] == '^') {
                posx = i;
                posy = j;
            }
        }
    }
    fclose(file);

    if (posx == -1 || posy == -1) {
        fprintf(stderr, "Starting position '^' not found\n");
        return 1;
    }

    // Allocate seen array for part A
    bool **seen = (bool **)malloc(size * sizeof(bool *));
    for (int i = 0; i < size; i++) {
        seen[i] = (bool *)calloc(size, sizeof(bool));
    }

    // Part A
    int result_a = follow_path(data, size, posy, posx, 10000, seen);
    printf("Part A: %d\n", result_a);

    // Part B
    int total = 0;
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            if (seen[i][j]) {
                data[j][i] = '#';
                if (-1 == follow_path(data, size, posy, posx, result_a + 10000, NULL)) {
                    total++;
                }
                data[j][i] = '.';
            }
        }
    }
    printf("Part B: %d\n", total);

    // Free allocated memory
    for (int i = 0; i < size; i++) {
        free(data[i]);
        free(seen[i]);
    }
    free(data);
    free(seen);

    return 0;
}