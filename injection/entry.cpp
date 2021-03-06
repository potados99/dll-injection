#include "entry.h"
#include "utils.h"

BOOL WINAPI DllMain(HINSTANCE hInst, DWORD dwReason, LPVOID) {
	TCHAR acModule[MAX_PATH];
	memset(acModule, 0, sizeof(acModule));

	GetModuleFileName(NULL, acModule, MAX_PATH);

	switch (dwReason) {

	case DLL_PROCESS_ATTACH: {
		TCHAR exeName[32];
		memset(exeName, 0, sizeof(exeName));

		RemovePath(exeName, acModule);

		Attached(exeName);

		break;
	}

	case DLL_PROCESS_DETACH: {
		// nothing

		break;
	}

	default: {
		break;
	}
	}

	return TRUE;
}

void Attached(LPSTR pstrFileName) {
	MakeLogFile(PROC_LOG_BASAEPATH, pstrFileName);

	if (LineExistsInFile(LISTFILE_PATH, pstrFileName)) {
		MakeLogFile(KILLED_LOG_BASAEPATH, pstrFileName);

		PostQuitMessage(99);
	}
	else { 
		MakeLogFile(ALIVE_LOG_BASAEPATH, pstrFileName);
	}
}
