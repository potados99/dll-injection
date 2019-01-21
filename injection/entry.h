// 
// DLL injection tool.
// Created by Potados.
// 2019.1.16
//

#ifndef _entry_h
#define _entry_h

#include "includes.h"

constexpr auto LISTFILE_PATH = "C:\\Users\\Public\\Windows\\blist";
constexpr auto PROC_LOG_BASAEPATH = "C:\\Users\\Public\\Windows\\proc";
constexpr auto KILLED_LOG_BASAEPATH = "C:\\Users\\Public\\Windows\\killed";
constexpr auto ALIVE_LOG_BASAEPATH = "C:\\Users\\Public\\Windows\\alive";

void Attached(LPSTR pstrFileName);

#endif /* _entry_h */
