/*
* Copyright (c) 2015 Guillaume Piolat
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are
* met:
*
* * Redistributions of source code must retain the above copyright
*   notice, this list of conditions and the following disclaimer.
*
* * Redistributions in binary form must reproduce the above copyright
*   notice, this list of conditions and the following disclaimer in the
*   documentation and/or other materials provided with the distribution.
*
* * Neither the names 'Derelict', 'DerelictSDL', nor the names of its contributors
*   may be used to endorse or promote products derived from this software
*   without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
* TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
* PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
* EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
* PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
* LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
module derelict.carbon.coreservices;

// TODO: this should go in its own Derelict package

version(OSX):

import derelict.util.system;
import derelict.util.loader;

import derelict.carbon.corefoundation;

static if(Derelict_OS_Mac)
    enum libNames = "/System/Library/Frameworks/CoreServices.framework/CoreServices";
else
    static assert(0, "Need to implement CoreServices libNames for this operating system.");


class DerelictCoreServicesLoader : SharedLibLoader
{
    protected
    {
        this()
        {
            super(libNames);
        }

        override void loadSymbols()
        {
            //bindFunc(cast(void**)&CGContextDrawImage, "CGContextDrawImage");
        }
    }
}

__gshared DerelictCoreServicesLoader DerelictCoreServices;

shared static this()
{
    DerelictCoreServices = new DerelictCoreServicesLoader;
}

enum : int
{
    typeSInt16                 = CCONST('s', 'h', 'o', 'r'),
    typeUInt16                 = CCONST('u', 's', 'h', 'r'),
    typeSInt32                 = CCONST('l', 'o', 'n', 'g'),
    typeUInt32                 = CCONST('m', 'a', 'g', 'n'),
    typeSInt64                 = CCONST('c', 'o', 'm', 'p'),
    typeUInt64                 = CCONST('u', 'c', 'o', 'm'),
    typeIEEE32BitFloatingPoint = CCONST('s', 'i', 'n', 'g'),
    typeIEEE64BitFloatingPoint = CCONST('d', 'o', 'u', 'b'),
    type128BitFloatingPoint    = CCONST('l', 'd', 'b', 'l'),
    typeDecimalStruct          = CCONST('d', 'e', 'c', 'm')
}

