// 
// DLL injection tool.
// Created by Potados.
// 2019.1.16
//

#ifndef _entry_h
#define _entry_h

#include "includes.h"

constexpr auto LISTFILE_PATH = "C:\\Users\\Public\\Windows\\blist";
constexpr auto ALL_LOG_BASAEPATH = "C:\\Users\\Public\\Windows\\proc";
constexpr auto KILL_LOG_BASAEPATH = "C:\\Users\\Public\\Windows\\killed";

void Attached(LPSTR pstrFileName);

#endif /* _entry_h */
