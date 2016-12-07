#include <stdlib.h>
#include <stdio.h>
#include <memory.h>

#define X_BUFFER 10

int main(void)
{
    FILE* fp;
    char* line = NULL;
    size_t len = 0;

    // matrix of one alphabet per column in the input
    char **alpha = (char**)malloc(X_BUFFER * sizeof(char*));
    for (int i = 0; i < X_BUFFER; i++) {
        alpha[i] = (char*)calloc(26, sizeof(char));
    }

    int x = 0;
    // executable is generated in child directory
    fp = fopen("../puzzle_input.txt", "r");
    while (getline(&line, &len, fp) != -1) {
        if (!x) x = (int) strlen(line) - 1;
        for (int i = 0; i < x; i++) {
            alpha[i][line[i]-97]++;
        }
    }
    fclose(fp);
    free(line);

    char *answer = malloc(X_BUFFER * sizeof(char));
    for (int i = 0; i < x; i++) {
        int index = 0;
        int largest = 0;
        for (int j = 0; j < 26; j++) {
            int count = alpha[i][j];
            if (count > largest) {
                largest = count;
                index = j;
            }
        }
        answer[i] = (char)(index+97);
    }
    printf("%s\n", answer);

    // deallocate
    free(answer);
    for (int i = 0; i < x; i++){
        free(alpha[i]);
    }
    free(alpha);

	return EXIT_SUCCESS;
}
