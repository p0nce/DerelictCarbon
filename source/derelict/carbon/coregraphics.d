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
module derelict.carbon.coregraphics;

// TODO: this should go in its own Derelict package

version(OSX):

import derelict.util.system;
import derelict.util.loader;

static if(Derelict_OS_Mac)
    enum libNames = "/System/Library/Frameworks/CoreGraphics.framework/CoreGraphics";
else
    static assert(0, "Need to implement CoreGraphics libNames for this operating system.");


class DerelictCoreGraphicsLoader : SharedLibLoader
{
    protected
    {
        this()
        {
            super(libNames);
        }

        override void loadSymbols()
        {
            bindFunc(cast(void**)&CGContextDrawImage, "CGContextDrawImage");
            bindFunc(cast(void**)&CGImageCreate, "CGImageCreate");
            bindFunc(cast(void**)&CGImageRelease, "CGImageRelease");
        }
    }
}

__gshared DerelictCoreGraphicsLoader DerelictCoreGraphics;

shared static this()
{
    DerelictCoreGraphics = new DerelictCoreGraphicsLoader;
}

unittest
{
    static if(Derelict_OS_Mac)
        DerelictCoreGraphics.load();
}

// <CoreGraphics/CGBase.h>

static if ((void*).sizeof > int.sizeof) // 64bit
    alias CGFloat = double;
else
    alias CGFloat = float;



// <CoreGraphics/CGGeometry.h>

struct CGPoint
{
    CGFloat x;
    CGFloat y;
}

struct CGSize
{
    CGFloat location;
    CGFloat length;
}

struct CGVector
{
    CGFloat dx;
    CGFloat dy;
}

struct CGRect
{
    CGPoint origin;
    CGSize size;
}

static immutable CGPoint CGPointZero = CGPoint(0, 0);
static immutable CGSize CGSizeZero = CGSize(0, 0);
static immutable CGRect CGRectZero = CGRect(CGPoint(0, 0), CGSize(0, 0));



// <CoreGraphics/CGContext.h>
alias CGColorRenderingIntent = int;
enum : CGColorRenderingIntent
{
    kCGRenderingIntentDefault,
    kCGRenderingIntentAbsoluteColorimetric,
    kCGRenderingIntentRelativeColorimetric,
    kCGRenderingIntentPerceptual,
    kCGRenderingIntentSaturation
}

// <CoreGraphics/CGContext.h>

alias CGContextRef = void*;
alias CGColorSpaceRef = void*;

extern (C) nothrow @nogc
{
    alias da_CGContextDrawImage = void function(CGContextRef, CGRect, CGImageRef);
}

__gshared
{
    da_CGContextDrawImage CGContextDrawImage;
}



// <CoreGraphics/CGDataProvider.h>

alias CGDataProviderRef = void*;


// <CoreGraphics/CGImage.h>

alias CGImageRef = void*;


alias CGBitmapInfo = uint;
enum : CGBitmapInfo
{
    kCGBitmapAlphaInfoMask = 0x1F,
    kCGBitmapFloatComponents = (1 << 8),
    kCGBitmapByteOrderMask = 0x7000,
    kCGBitmapByteOrderDefault = (0 << 12),
    kCGBitmapByteOrder16Little = (1 << 12),
    kCGBitmapByteOrder32Little = (2 << 12),
    kCGBitmapByteOrder16Big = (3 << 12),
    kCGBitmapByteOrder32Big = (4 << 12)
}


extern (C) nothrow @nogc
{
    alias da_CGImageRelease = void function(CGImageRef);

    alias da_CGImageCreate = CGImageRef function(size_t width, size_t height, size_t bitsPerComponent,
                                                 size_t bitsPerPixel, size_t bytesPerRow,
                                                 CGColorSpaceRef space, CGBitmapInfo bitmapInfo,
                                                 CGDataProviderRef provider, const CGFloat *decode,
                                                 bool shouldInterpolate, CGColorRenderingIntent intent);
}

__gshared
{
    da_CGImageRelease CGImageRelease;
    da_CGImageCreate CGImageCreate;
}

