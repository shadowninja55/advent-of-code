#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const int NLINES = 1000;
const char* NAMES[] = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};

int one(char* lines[NLINES]) {
  int r = 0;
  for (int i = 0; i < NLINES; i++) {
    const char* line = lines[i];
    char num[256] = {0};
    char *digit = num;
    while (*line) {
      if (isdigit(*line)) {
        *digit++ = *line;
      }
      line++;
    } 
    r += (*num - '0') * 10 + *--digit - '0';
  }
  return r;
}

int two(char* lines[NLINES]) {
  int r = 0;
  for (int i = 0; i < NLINES; i++) {
    const char* line = lines[i];
    char num[256] = {0};
    char *digit = num;
    while (*line) {
      if (isdigit(*line)) {
        *digit++ = *line;
      } else {
        for (int j = 1; j < 10; j++) {
          const char* name = NAMES[j - 1];
          if (!strncmp(line, name, strlen(name))) {
            *digit++ = j + '0';
            break;
          }
        }
      }
      line++;
    }
    r += (*num - '0') * 10 + *--digit - '0';
  }
  return r;
}


int main(void) {
  FILE* file = fopen("input.txt", "r");
  char* lines[NLINES];
  char buffer[256];
  for (int i = 0; i < NLINES; i++) {
    fgets(buffer, sizeof(buffer), file);
    int len = strlen(buffer);
    buffer[--len] = 0;
    lines[i] = malloc(len + 1);
    strcpy(lines[i], buffer);
  }
  fclose(file);
  printf("%d\n", one(lines));
  printf("%d\n", two(lines));
  return 0;
}
