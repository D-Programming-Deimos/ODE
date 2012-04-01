/*************************************************************************
 *                          D bindings for ODE                           *
 *                                                                       *
 *       C header port by Daniel "q66" Kolesa <quaker66@gmail.com>       *
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001-2003 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * This library is free software; you can redistribute it and/or         *
 * modify it under the terms of EITHER:                                  *
 *   (1) The GNU Lesser General Public License as published by the Free  *
 *       Software Foundation; either version 2.1 of the License, or (at  *
 *       your option) any later version. The text of the GNU Lesser      *
 *       General Public License is included with this library in the     *
 *       file LICENSE.TXT.                                               *
 *   (2) The BSD-style license that is included with this library in     *
 *       the file LICENSE-BSD.TXT.                                       *
 *                                                                       *
 * This library is distributed in the hope that it will be useful,       *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the files    *
 * LICENSE.TXT and LICENSE-BSD.TXT for more details.                     *
 *                                                                       *
 *************************************************************************/

/* this comes from the `reuse' library. copy any changes back to the source */

module deimos.ode.memory;

private import deimos.ode.odeconfig;

extern (C):
nothrow:

/* function types to allocate and free memory */
alias void* function(size_t size) dAllocFunction;
alias void* function(void* ptr, size_t oldsz, size_t newsz) dReallocFunction;
alias void function(void* ptr, size_t size) dFreeFunction;

/* set new memory management functions. if fn is 0, the default handlers are
 * used. */
void dSetAllocHandler(dAllocFunction fn);
void dSetReallocHandler(dReallocFunction fn);
void dSetFreeHandler(dFreeFunction fn);

/* get current memory management functions */
dAllocFunction dGetAllocHandler();
dReallocFunction dGetReallocHandler();
dFreeFunction dGetFreeHandler();

/* allocate and free memory. */
void* dAlloc(size_t size);
void* dRealloc(void* ptr, size_t oldsize, size_t newsize);
void dFree (void* ptr, size_t size);
