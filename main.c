#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>


char text[1000000001], generated_text[1000000001];
size_t text_size;

void count_letters(char[], size_t, int*, int*);

void input_text(FILE *fin) {
    char c;
    text_size = 0;
    while ((c = fgetc(fin)) != EOF) {
        text[text_size++] = c;
    }
}
void gen_text(size_t size) {
    const int allowed_characters_range_l = 32,
              allowed_characters_range_r = 126;
    srand(time(NULL));
    
    for (size_t i = 0; i < size; i++) {
        generated_text[i] = rand() % (allowed_characters_range_r - allowed_characters_range_l + 1) + allowed_characters_range_l;
    }
    generated_text[size] = '\0';
}

int main(int argc, char *argv[]) {
    FILE *fin, *fout;

    if (argc == 1) {
        fprintf(stderr, "No parameters are provided\n");
        return 1;
    }

    if (!strcmp(argv[1], "-i")) {
        fin = stdin;
        fout = stdout;
    } else if (!strcmp(argv[1], "-f")) {
        if (argc < 4) {
            fprintf(stderr, "Input/output files are not provided\n");
            return 1;
        }
        fin = fopen(argv[2], "r");
        fout = fopen(argv[3], "w");
    } else if (!strcmp(argv[1], "-g")) {
        if (argc != 3) {
            fprintf(stderr, "The size of the generating text is not provided\n");
            return 1;
        }
        size_t size = atoi(argv[2]);

        gen_text(size);
        fin = fmemopen(generated_text, size, "r");
        fout = stdout;
    } else {
        fprintf(stderr, "Invalid parameter");
        return 1;
    }
    
    input_text(fin);

    int lower_count = 0, upper_count = 0;

    int iterations = 5;

    clock_t start = clock();
    for (int i = 0; i < iterations; i++) {
        count_letters(text, text_size, &lower_count, &upper_count); 
    }
    clock_t end = clock();

    fprintf(fout, "The number of lowercase letters is %d.\n", lower_count);
    fprintf(fout, "The number of uppercase letters is %d.\n", upper_count);

    fprintf(fout, "The average time of the calculating: %f clocks or %f seconds\n", (end - start) / (double)iterations, (end - start) / (double) iterations / CLOCKS_PER_SEC);    

    if (fin != stdin) {
        fclose(fin);    
    }
    
    if (fout != stdout) {
        fclose(fout);
    }
}