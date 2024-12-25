// compile and run with `gcc -o 06t 06_threaded.c -O3 -march=native -fomit-frame-pointer -funroll-loops -flto; time ./06t`
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <pthread.h>

#define MAX_THREADS 24  // Adjust based on the number of CPU cores

// Direction lookup table: {dx, dy}
int DIR_LOOKUP[4][2] = {
    {0, -1},  // Up
    {1, 0},   // Right
    {0, 1},   // Down
    {-1, 0}   // Left
};

typedef struct {
    char **data;
    int size;
    int posx;
    int posy;
    int max_steps;
    bool **seen;
    int start_row;
    int end_row;
    int *total;
} ThreadData;

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
            dir = (dir + 1) % 4;  // Reverse direction
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
    return steps < max_steps ? steps : -1;
}

void *process_grid(void *arg) {
    ThreadData *data = (ThreadData *)arg;
    int local_total = 0;

    // Create a copy of the data array for this thread
    char **local_data = (char **)malloc(data->size * sizeof(char *));
    for (int i = 0; i < data->size; i++) {
        local_data[i] = (char *)malloc(data->size * sizeof(char));
        for (int j = 0; j < data->size; j++) {
            local_data[i][j] = data->data[i][j];
        }
    }

    for (int i = data->start_row; i < data->end_row; i++) {
        for (int j = 0; j < data->size; j++) {
            if (data->seen[i][j]) {
                local_data[j][i] = '#';
                if (-1 == follow_path(local_data, data->size, data->posy, data->posx, data->max_steps, NULL)) {
                    local_total++;
                }
                local_data[j][i] = '.';
            }
        }
    }

    // Free the local data array
    for (int i = 0; i < data->size; i++) {
        free(local_data[i]);
    }
    free(local_data);

    *(data->total) = local_total;
    pthread_exit(NULL);
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
    int max_steps_b = result_a + 1000;

    pthread_t threads[MAX_THREADS];
    ThreadData thread_data[MAX_THREADS];
    int thread_total[MAX_THREADS] = {0};

    int rows_per_thread = size / MAX_THREADS;
    for (int i = 0; i < MAX_THREADS; i++) {
        thread_data[i] = (ThreadData){
            .data = data,
            .size = size,
            .posx = posx,
            .posy = posy,
            .max_steps = max_steps_b,
            .seen = seen,
            .start_row = i * rows_per_thread,
            .end_row = (i + 1) * rows_per_thread,
            .total = &thread_total[i]
        };

        if (i == MAX_THREADS - 1) {
            thread_data[i].end_row = size;
        }

        pthread_create(&threads[i], NULL, process_grid, &thread_data[i]);
    }

    for (int i = 0; i < MAX_THREADS; i++) {
        pthread_join(threads[i], NULL);
        total += thread_total[i];
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