/*
 * Copyright (C) 2015, Simon Fuhrmann, Nils Moehrle
 * TU Darmstadt - Graphics, Capture and Massively Parallel Computing
 * All rights reserved.
 *
 * This software may be modified and distributed under the terms
 * of the BSD 3-Clause license. See the LICENSE.txt file for details.
 */

#if defined(_WIN32)
#   include <Windows.h>
#else // Linux, OSX, ...
#   include <unistd.h>
#   include <sys/types.h>
#endif

#include "util/process.h"

UTIL_NAMESPACE_BEGIN
UTIL_PROCESS_NAMESPACE_BEGIN

int get_pid (void)
{
#ifdef _WIN32
    // FIXME: DWORD is 32-bit unsigned int
    static DWORD pid = GetCurrentProcessId();
#else // _WIN32
    static pid_t pid = getpid();
#endif // _WIN32
    return pid;
}

UTIL_PROCESS_NAMESPACE_END
UTIL_NAMESPACE_END
