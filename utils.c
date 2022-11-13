#include <stdbool.h>
#include <stdlib.h>

static bool is_lower(char letter) {
    return 'a' <= letter && letter <= 'z';
}

static bool is_upper(char letter) {
    return 'A' <= letter && letter <= 'Z';
}

void count_letters(char *text, size_t size, int *lower_count, int *upper_count) {
    *lower_count = 0;
    *upper_count = 0;
    for (size_t i = 0; i < size; i++) {
        *lower_count += is_lower(text[i]);
        *upper_count += is_upper(text[i]);
    }
}