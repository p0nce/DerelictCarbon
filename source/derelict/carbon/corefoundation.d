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
module derelict.carbon.corefoundation;

// TODO: this should go in the existing Derelict package DerelictCF

version(OSX):

import core.stdc.config;

import derelict.util.system;
import derelict.util.loader;

static if(Derelict_OS_Mac)
    enum libNames = "/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation";
else
    static assert(0, "Need to implement CoreFoundation libNames for this operating system.");


class DerelictCoreFoundationLoader : SharedLibLoader
{
    protected
    {
        this()
        {
            super(libNames);
        }

        override void loadSymbols()
        {
            bindFunc(cast(void**)&CFStringCreateWithCString, "CFStringCreateWithCString");
        }
    }
}

__gshared DerelictCoreFoundationLoader DerelictCoreFoundation;

shared static this()
{
    DerelictCoreFoundation = new DerelictCoreFoundationLoader;
}

// To support character constants
package int CCONST(int a, int b, int c, int d) pure nothrow
{
    return (a << 24) | (b << 16) | (c << 8) | (d << 0);
}


// <MacTypes.h>

alias UInt8 = ubyte;
alias SInt8 = byte;
alias UInt16 = ushort;
alias SInt16 = short;
alias UInt32 = uint;
alias SInt32 = int;
alias UInt64 = ulong;
alias SInt64 = long;


  // binary layout should be what is expected on this platform
version (LittleEndian)
{
    struct wide
    {
        UInt32              lo;
        SInt32              hi;
    }

    struct UnsignedWide
    {
        UInt32              lo;
        UInt32              hi;
    }
}
else
{
    struct wide
    {
        SInt32              hi;
        UInt32              lo;
    }

    struct UnsignedWide
    {
        UInt32              hi;
        UInt32              lo;
    }
}


alias Fixed = SInt32;
alias FixedPtr = Fixed*;
alias Fract = SInt32;
alias FractPtr = Fract*;
alias UnsignedFixed = UInt32;
alias UnsignedFixedPtr = UnsignedFixed*;
alias ShortFixed = short;
alias ShortFixedPtr = ShortFixed*;

alias Float32 = float;
alias Float64 = double;

alias Ptr = char*;
alias Handle = Ptr*;
alias Size = long;


alias OSErr = SInt16;
alias OSStatus = SInt32;
alias LogicalAddress = void*;
alias ConstLogicalAddress = const(void)*;
alias PhysicalAddress = void*;
alias BytePtr = UInt8*;
alias ByteCount = c_ulong;
alias ByteOffset = c_ulong;
alias Duration = SInt32;
alias AbsoluteTime = UnsignedWide;
alias OptionBits = UInt32;
alias ItemCount = c_ulong;
alias PBVersion = UInt32;
alias ScriptCode = SInt16;
alias LangCode = SInt16;
alias RegionCode = SInt16;
alias FourCharCode = UInt32;
alias OSType = FourCharCode;
alias ResType = FourCharCode;
alias OSTypePtr = OSType*;
alias ResTypePtr = ResType*;

enum
{
    noErr                         = 0,
    kNilOptions                   = 0,
    kInvalidID                    = 0,
    kVariableLengthArray          = 1,
    kUnknownType                  = 0x3F3F3F3F
}

alias UnicodeScalarValue = UInt32;
alias UTF32Char = UInt32;
alias UniChar = UInt16;
alias UTF16Char = UInt16;
alias UTF8Char = UInt8;
alias UniCharPtr = UniChar*;
alias UniCharCount = c_ulong;
alias UniCharCountPtr = UniCharCount*;
alias Str255 = char[256];
alias Str63 = char[64];
alias Str32 = char[33];
alias Str31 = char[32];
alias Str27 = char[28];
alias Str15 = char[16];


// <CoreFoundation/CFBase.h>


alias Boolean = ubyte;

alias StringPtr = char*;
alias ConstStringPtr = const(char)*;
alias ConstStr255Param = const(char)*;
alias Byte = UInt8;
alias SignedByte = SInt8;


alias CFTypeID = ulong;
alias CFOptionFlags = ulong;
alias CFHashCode = ulong;
alias CFIndex = long;

alias CFTypeRef = const(void)*;

alias CFStringRef = void*;
alias CFMutableStringRef = void*;
alias CFAllocatorRef = void*;

alias CFPropertyListRef = CFTypeRef;


struct CFRange
{
    CFIndex location;
    CFIndex length;
}

CFRange CFRangeMake(CFIndex loc, CFIndex len)
{
    return CFRange(loc, len);
}

alias CFNullRef = const(void)*;

struct Point
{
    short               v;
    short               h;
}
alias PointPtr = Point*;

struct Rect
{
  short               top;
  short               left;
  short               bottom;
  short               right;
}
alias RectPtr = Rect*;


// <CoreFoundation/CFString.h>

alias CFStringEncoding = UInt32;
alias CFStringBuiltInEncodings = CFStringEncoding;
enum : CFStringBuiltInEncodings
{
    kCFStringEncodingMacRoman = 0,
    kCFStringEncodingWindowsLatin1 = 0x0500,
    kCFStringEncodingISOLatin1 = 0x0201,
    kCFStringEncodingNextStepLatin = 0x0B01,
    kCFStringEncodingASCII = 0x0600,
    kCFStringEncodingUnicode = 0x0100,
    kCFStringEncodingUTF8 = 0x08000100,
    kCFStringEncodingNonLossyASCII = 0x0BFF,

    kCFStringEncodingUTF16 = 0x0100,
    kCFStringEncodingUTF16BE = 0x10000100,
    kCFStringEncodingUTF16LE = 0x14000100,

    kCFStringEncodingUTF32 = 0x0c000100,
    kCFStringEncodingUTF32BE = 0x18000100,
    kCFStringEncodingUTF32LE = 0x1c000100
}

extern(C) nothrow @nogc
{
    alias da_CFStringCreateWithCString = CFStringRef function(CFAllocatorRef, const(char)*, CFStringEncoding);
}

__gshared
{
    da_CFStringCreateWithCString CFStringCreateWithCString;
}




