#ifndef _utils_h
#define _utils_h

#include "includes.h"

void RemovePath(LPSTR pstrDest, LPSTR pstrSource);
void MakeLogFile(LPCSTR pcstrBasePath, LPSTR pstrFileName);
BOOL FindLine(LPCSTR pcstrListFile, LPSTR pstrToFind);

#endif /* _utils_h */
