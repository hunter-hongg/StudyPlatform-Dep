#include <stdint.h>

typedef struct {
    char* ChaHu;
    char* ChaZhan;
    int32_t AddNum;
} GuWanChaFiles;
GuWanChaFiles* GuWanChaFiles_Make(char*, char*, int32_t);
void GuWanChaFiles_Free(GuWanChaFiles*);
int32_t GuWanChaFiles_Read(GuWanChaFiles*, int32_t);
void GuWanChaFiles_Add(GuWanChaFiles*, int32_t, int32_t);