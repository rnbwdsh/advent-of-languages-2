#include <stdio.h>


void bubble_sort(int* arr, int cur_line) {
  for (int i = 0; i < cur_line; i++) {
    for (int j = 0; j < cur_line - i - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
      }
    }
  }
}

int count_in_until(const int i, const int* arr, int curr_line)
{
  int total = 0;
  for (int j = 0; j < curr_line; j++) {
    if (arr[j] == i) {
      total++;
    }
  }
  return total;
}

void main(int argc, char** argv) {
  int left[1000];
  int right[1000];
  char curr;
  int curr_line = 0;
  unsigned int read_ret = 0;

  FILE* f = fopen("01.in", "r");
  while (read_ret) {
    read_ret = fscanf(f, "%d   %d\n", &left[curr_line], &right[curr_line]);
  }
  // bubble sort left and right up to curLine
  bubble_sort(left, curr_line);
  bubble_sort(right, curr_line);
  int sum = 0;

  if(argc > 1)
  {
    // sum up left * right
    for (int i = 0; i < curr_line; i++) {
      int diff = left[i] - right[i];
      if (diff < 0) {
        diff = -diff;
      }
      sum += diff;
    }
  } else
  {
    for (int i = 0; i < curr_line; i++) {
      int cnt = count_in_until(left[i], right, curr_line);
      sum += left[i] * cnt;
    }
  }
  printf("%d\n", sum);
}
