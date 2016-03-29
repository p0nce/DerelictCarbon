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
module derelict.carbon.audiounit;

// Not strictly in Carbon, this is technical debt

version(OSX):

import core.stdc.config;

import derelict.util.system;
import derelict.util.loader;

import derelict.carbon.corefoundation;

static if(Derelict_OS_Mac)
    enum libNames = "/System/Library/Frameworks/AudioUnit.framework/AudioUnit";
else
    static assert(0, "Need to implement AudioUnit libNames for this operating system.");


class DerelictAudioUnitLoader : SharedLibLoader
{
    protected
    {
        this()
        {
            super(libNames);
        }

        override void loadSymbols()
        {
          //  bindFunc(cast(void**)&SetComponentInstanceStorage, "SetComponentInstanceStorage");
        }
    }
}

__gshared DerelictAudioUnitLoader DerelictAudioUnit;

shared static this()
{
    DerelictAudioUnit = new DerelictAudioUnitLoader;
}

enum : int
{
    kAudioUnitRange                                    = 0x0000,
    kAudioUnitInitializeSelect                         = 0x0001,
    kAudioUnitUninitializeSelect                       = 0x0002,
    kAudioUnitGetPropertyInfoSelect                    = 0x0003,
    kAudioUnitGetPropertySelect                        = 0x0004,
    kAudioUnitSetPropertySelect                        = 0x0005,
    kAudioUnitAddPropertyListenerSelect                = 0x000A,
    kAudioUnitRemovePropertyListenerSelect             = 0x000B,
    kAudioUnitRemovePropertyListenerWithUserDataSelect = 0x0012,
    kAudioUnitAddRenderNotifySelect                    = 0x000F,
    kAudioUnitRemoveRenderNotifySelect                 = 0x0010,
    kAudioUnitGetParameterSelect                       = 0x0006,
    kAudioUnitSetParameterSelect                       = 0x0007,
    kAudioUnitScheduleParametersSelect                 = 0x0011,
    kAudioUnitRenderSelect                             = 0x000E,
    kAudioUnitResetSelect                              = 0x0009,
    kAudioUnitComplexRenderSelect                      = 0x0013,
    kAudioUnitProcessSelect                            = 0x0014,
    kAudioUnitProcessMultipleSelect                    = 0x0015
}
