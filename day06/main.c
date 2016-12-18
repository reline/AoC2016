#include <stdlib.h>
#include <stdio.h>
#include <memory.h>

int main(void)
{
    FILE* fp;
    char* line = NULL;
    size_t len = 0;

    // executable is generated in child directory
    fp = fopen("../puzzle_input.txt", "r");

    // determine how much memory to allocate
    getline(&line, &len, fp);
    ssize_t x = strlen(line) - 1;
    for (ssize_t k = x; k >= 0; k--) {
        ungetc(line[k], fp);
    }

    // matrix of one alphabet per column in the input
    char **alpha = (char**)malloc(x * sizeof(char*));
    for (int i = 0; i < x; i++) {
        alpha[i] = (char*)calloc(26, sizeof(char));
    }

    while (getline(&line, &len, fp) != -1) {
        for (int i = 0; i < x; i++) {
            alpha[i][line[i]-97]++;
        }
    }
    fclose(fp);
    free(line);

    char *answer_one = malloc(x * sizeof(char));
    char *answer_two = malloc(x * sizeof(char));
    for (int i = 0; i < x; i++) {
        int index_one = 0;
        int index_two = 0;
        int largest = -1;
        int smallest = 26;
        for (int j = 0; j < 26; j++) {
            int count = alpha[i][j];
            if (count > largest) {
                largest = count;
                index_one = j;
            }
            if (count < smallest) {
                smallest = count;
                index_two = j;
            }
        }
        answer_one[i] = (char)(index_one+97);
        answer_two[i] = (char)(index_two+97);
    }
    printf("%s", answer_one);
    printf("%s", answer_two);

    // deallocate
    free(answer_one);
    free(answer_two);
    for (int i = 0; i < x; i++){
        free(alpha[i]);
    }
    free(alpha);

	return EXIT_SUCCESS;
}
