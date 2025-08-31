#include <stdint.h>

typedef struct {
    char* Level1;
    char* Level2;
    char* Level3;
    int32_t Addnum;
} BookShelfFiles;
typedef struct {
    int32_t Level1;
    int32_t Level2;
    int32_t Level3;
} BookShelfResult; 

BookShelfFiles* BookShelfFiles_New(char*, char*, char*, int32_t);
void BookShelfFiles_Free(BookShelfFiles*);
BookShelfResult* BookShelfFiles_Read(BookShelfFiles*);
void BookShelfResult_Free(BookShelfFiles*);
int32_t BookShelfFiles_WriteLevel1(BookShelfFiles*, int32_t);
int32_t BookShelfFiles_WriteLevel2(BookShelfFiles*, int32_t);
int32_t BookShelfFiles_WriteLevel3(BookShelfFiles*, int32_t);