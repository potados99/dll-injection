#include "utils.h"

void RemovePath(LPSTR pstrDest, LPSTR pstrSource) {
	// assum pstrDest is cleared and pstrSource is null-terminated.

	int sourceLen = (int)strlen(pstrSource);
	for (int i = sourceLen - 1; i >= 0; --i) {
		// from right index

		char crntchar = pstrSource[i];
		if (crntchar == '\\') {
			int bgn = i + 1;
			int end = sourceLen - 1;

			memcpy(pstrDest, pstrSource + bgn, end - bgn + 1);

			return;
		}
	}
}

void MakeLogFile(LPCSTR pcstrBasePath, LPSTR pstrFileName) {
	TCHAR path[128];
	memset(path, 0, sizeof(path));

	// assert directory to be.
	if (!DirectoryExists(pcstrBasePath)) {
		BOOL suc = CreateDirectory(pcstrBasePath, NULL);
		if (!suc) {
			exit(2);
		}
	}

	strcat(path, pcstrBasePath);
	if (pcstrBasePath[strlen(pcstrBasePath) - 1] != '\\') {
		strcat(path, "\\");
	}
	strcat(path, pstrFileName);
	path[strlen(path)] = '\0';

	FILE *checkFile = fopen(path, "w+");
	if (checkFile == NULL) {
		// path wrong or etc..
		exit(1);
	}

	fclose(checkFile);
}

BOOL DirectoryExists(LPCSTR pcstrDirectory)
{
	DWORD fileType = GetFileAttributes(pcstrDirectory);
	if (fileType == INVALID_FILE_ATTRIBUTES) {
		return FALSE; /* path wrong. doesn't exist. */
	}
	else if (fileType == FILE_ATTRIBUTE_DIRECTORY) {
		return TRUE; /* it is a directory. */
	}

	return FALSE; /* exists but not a directory. */
}

BOOL LineExistsInFile(LPCSTR pcstrListFile, LPSTR pstrToFind) {
	FILE *pFile;
	LPSTR readBufPtr;
	long lSize;
	size_t result;
	TCHAR line[128];

	pFile = fopen(pcstrListFile, "rt");
	if (pFile == NULL) {
		return FALSE;
	}

	fseek(pFile, 0, SEEK_END);
	lSize = ftell(pFile);
	rewind(pFile);

	readBufPtr = (LPSTR)malloc(sizeof(char) * lSize + 1);
	if (readBufPtr == NULL) {
		fclose(pFile);

		return FALSE;
	}
	memset(readBufPtr, 0, sizeof(char) * lSize + 1);

	result = fread(readBufPtr, 1, lSize, pFile);
	if (result == 0) {
		fclose(pFile);
		free(readBufPtr);

		return FALSE;
	}
	readBufPtr[result] = '\0';

	fclose(pFile);

	memset(line, 0, sizeof(line));

	for (int i = 0; i < (int)strlen(readBufPtr) + 1; ++i) {
		char crnchar = readBufPtr[i];

		if (crnchar == ' ') {
			continue;
		}
		if (crnchar == '\n' || crnchar == '\0') {
			line[strlen(line)] = '\0';
			// line is completed here.

			bool isComment = line[0] == '/' && line[1] == '/';
			bool matched = (stricmp(line, pstrToFind) == 0);

			if (!isComment && matched) {
				free(readBufPtr);

				return TRUE;
			}

			memset(line, 0, sizeof(line));

			continue;
		}

		line[strlen(line)] = crnchar;
	}

	free(readBufPtr);

	return FALSE;
}
