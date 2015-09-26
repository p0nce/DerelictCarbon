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
module derelict.carbon.hitoolbox;

version(OSX):

import derelict.carbon.types;

// <HIToolbox/CarbonEventsCore.h.h>

alias EventRef = void*;
alias EventLoopRef = void*;
alias EventHandlerRef = void*;
alias EventHandlerCallRef = void*;
alias EventTargetRef = void*;

alias EventTime = double;
alias EventTimeout = EventTime;
alias EventTimerInterval = EventTime;


struct EventTypeSpec
{
    OSType eventClass;
    UInt32 eventKind;
}

extern (C) nothrow @nogc
{
    alias da_GetMainEventLoop = EventLoopRef function();
    alias da_InstallEventHandler = OSStatus function(EventTargetRef, EventHandlerUPP, ItemCount, const(EventTypeSpec)*, void*, EventHandlerRef*);
}

__gshared
{
    da_GetMainEventLoop GetMainEventLoop;
    da_InstallEventHandler InstallEventHandler;
}

extern(C) nothrow
{
    alias EventHandlerProcPtr = OSStatus function(EventHandlerCallRef inHandlerCallRef, EventRef inEvent, void *inUserData);
    alias EventHandlerUPP = EventHandlerProcPtr;
}

// <HIToolbox/CarbonEvents.h.h>

enum : int
{
  kEventClassMouse              = CCONST('m', 'o', 'u', 's'),
  kEventClassKeyboard           = CCONST('k', 'e', 'y', 'b'),
  kEventClassTextInput          = CCONST('t', 'e', 'x', 't'),
  kEventClassApplication        = CCONST('a', 'p', 'p', 'l'),
  kEventClassAppleEvent         = CCONST('e', 'p', 'p', 'c'),
  kEventClassMenu               = CCONST('m', 'e', 'n', 'u'),
  kEventClassWindow             = CCONST('w', 'i', 'n', 'd'),
  kEventClassControl            = CCONST('c', 'n', 't', 'l'),
  kEventClassCommand            = CCONST('c', 'm', 'd', 's'),
  kEventClassTablet             = CCONST('t', 'b', 'l', 't'),
  kEventClassVolume             = CCONST('v', 'o', 'l', ' '),
  kEventClassAppearance         = CCONST('a', 'p', 'p', 'm'),
  kEventClassService            = CCONST('s', 'e', 'r', 'v'),
  kEventClassToolbar            = CCONST('t', 'b', 'a', 'r'),
  kEventClassToolbarItem        = CCONST('t', 'b', 'i', 't'),
  kEventClassToolbarItemView    = CCONST('t', 'b', 'i', 'v'),
  kEventClassAccessibility      = CCONST('a', 'c', 'c', 'e'),
  kEventClassSystem             = CCONST('m', 'a', 'c', 's'),
  kEventClassInk                = CCONST('i', 'n', 'k', ' '),
  kEventClassTSMDocumentAccess  = CCONST('t', 'd', 'a', 'c'),
  kEventClassGesture            = CCONST('g', 'e', 's', 't')
}

enum : int
{
    kEventControlInitialize                     = 1000,
    kEventControlDispose                        = 1001,
    kEventControlGetOptimalBounds               = 1003,
    kEventControlOptimalBoundsChanged           = 1004,
    kEventControlDefInitialize                  = kEventControlInitialize,
    kEventControlDefDispose                     = kEventControlDispose,
    kEventControlHit                            = 1,
    kEventControlSimulateHit                    = 2,
    kEventControlHitTest                        = 3,
    kEventControlDraw                           = 4,
    kEventControlApplyBackground                = 5,
    kEventControlApplyTextColor                 = 6,
    kEventControlSetFocusPart                   = 7,
    kEventControlGetFocusPart                   = 8,
    kEventControlActivate                       = 9,
    kEventControlDeactivate                     = 10,
    kEventControlSetCursor                      = 11,
    kEventControlContextualMenuClick            = 12,
    kEventControlClick                          = 13,
    kEventControlGetNextFocusCandidate          = 14,
    kEventControlGetAutoToggleValue             = 15,
    kEventControlInterceptSubviewClick          = 16,
    kEventControlGetClickActivation             = 17,
    kEventControlDragEnter                      = 18,
    kEventControlDragWithin                     = 19,
    kEventControlDragLeave                      = 20,
    kEventControlDragReceive                    = 21,
    kEventControlInvalidateForSizeChange        = 22,
    kEventControlTrackingAreaEntered            = 23,
    kEventControlTrackingAreaExited             = 24,
    kEventControlTrack                          = 51,
    kEventControlGetScrollToHereStartPoint      = 52,
    kEventControlGetIndicatorDragConstraint     = 53,
    kEventControlIndicatorMoved                 = 54,
    kEventControlGhostingFinished               = 55,
    kEventControlGetActionProcPart              = 56,
    kEventControlGetPartRegion                  = 101,
    kEventControlGetPartBounds                  = 102,
    kEventControlSetData                        = 103,
    kEventControlGetData                        = 104,
    kEventControlGetSizeConstraints             = 105,
    kEventControlGetFrameMetrics                = 106,
    kEventControlValueFieldChanged              = 151,
    kEventControlAddedSubControl                = 152,
    kEventControlRemovingSubControl             = 153,
    kEventControlBoundsChanged                  = 154,
    kEventControlVisibilityChanged              = 157,
    kEventControlTitleChanged                   = 158,
    kEventControlOwningWindowChanged            = 159,
    kEventControlHiliteChanged                  = 160,
    kEventControlEnabledStateChanged            = 161,
    kEventControlLayoutInfoChanged              = 162,
    kEventControlFocusPartChanged               = 164,
    kEventControlArbitraryMessage               = 201
}

enum : int
{
    kEventMouseDown                 = 1,
    kEventMouseUp                   = 2,
    kEventMouseMoved                = 5,
    kEventMouseDragged              = 6,
    kEventMouseEntered              = 8,
    kEventMouseExited               = 9,
    kEventMouseWheelMoved           = 10,
    kEventMouseScroll               = 11
}


OSStatus InstallControlEventHandler(ControlRef target, EventHandlerUPP handler, ItemCount numTypes,
                                    const(EventTypeSpec)* list, void* userData, EventHandlerRef* outHandlerRef)
{
    return InstallEventHandler(GetControlEventTarget(target), handler, numTypes, list, userData, outHandlerRef);
}

extern (C) nothrow @nogc
{
    alias da_GetControlEventTarget = EventTargetRef function(ControlRef);
}

__gshared
{
    da_GetControlEventTarget GetControlEventTarget;
}


// <HIToolbox/Controls.h>

enum : int
{
  kControlSupportsGhosting      = 1 << 0,
  kControlSupportsEmbedding     = 1 << 1,
  kControlSupportsFocus         = 1 << 2,
  kControlWantsIdle             = 1 << 3,
  kControlWantsActivate         = 1 << 4,
  kControlHandlesTracking       = 1 << 5,
  kControlSupportsDataAccess    = 1 << 6,
  kControlHasSpecialBackground  = 1 << 7,
  kControlGetsFocusOnClick      = 1 << 8,
  kControlSupportsCalcBestRect  = 1 << 9,
  kControlSupportsLiveFeedback  = 1 << 10,
  kControlHasRadioBehavior      = 1 << 11,
  kControlSupportsDragAndDrop   = 1 << 12,
  kControlAutoToggles           = 1 << 14,
  kControlSupportsGetRegion     = 1 << 17,
  kControlSupportsFlattening    = 1 << 19,
  kControlSupportsSetCursor     = 1 << 20,
  kControlSupportsContextualMenus = 1 << 21,
  kControlSupportsClickActivation = 1 << 22,
  kControlIdlesWithTimer        = 1 << 23,
  kControlInvertsUpDownValueMeaning = 1 << 24
}


// <HIToolbox/HIContainerViews.h>

extern (C) nothrow @nogc
{
    alias da_CreateUserPaneControl = OSStatus function(WindowRef, const(Rect)*, UInt32, ControlRef*);
}

__gshared
{
    da_CreateUserPaneControl CreateUserPaneControl;
}



// <HIToolbox/HIObject.h>

alias ControlRef = void*;



// <HIToolbox/HIView.h>

enum : int
{
  kHIViewFeatureSupportsGhosting = 1 << 0,
  kHIViewFeatureAllowsSubviews  = 1 << 1,
  kHIViewFeatureGetsFocusOnClick = 1 << 8,
  kHIViewFeatureSupportsLiveFeedback = 1 << 10,
  kHIViewFeatureSupportsRadioBehavior = 1 << 11,
  kHIViewFeatureAutoToggles     = 1 << 14,
  kHIViewFeatureIdlesWithTimer  = 1 << 23,
  kHIViewFeatureInvertsUpDownValueMeaning = 1 << 24,
  kHIViewFeatureIsOpaque        = 1 << 25,
  kHIViewFeatureDoesNotDraw     = 1 << 27,
  kHIViewFeatureDoesNotUseSpecialParts = 1 << 28,
  kHIViewFeatureIgnoresClicks   = 1 << 29
}




// <HIToolbox/MacWindows.h>

alias OptionBits = int;  //?
alias WindowClass = int;
alias WindowAttributes = OptionBits;

enum : int
{
    kHIWindowBitCloseBox          = 1,
    kHIWindowBitZoomBox           = 2,
    kHIWindowBitCollapseBox       = 4,
    kHIWindowBitResizable         = 5,
    kHIWindowBitSideTitlebar      = 6,
    kHIWindowBitToolbarButton     = 7,
    kHIWindowBitUnifiedTitleAndToolbar = 8,
    kHIWindowBitTextured          = 9,
    kHIWindowBitNoTitleBar        = 10,
    kHIWindowBitTexturedSquareCorners = 11,
    kHIWindowBitNoTexturedContentSeparator = 12,
    kHIWindowBitRoundBottomBarCorners = 13,
    kHIWindowBitDoesNotCycle      = 16,
    kHIWindowBitNoUpdates         = 17,
    kHIWindowBitNoActivates       = 18,
    kHIWindowBitOpaqueForEvents   = 19,
    kHIWindowBitCompositing       = 20,
    kHIWindowBitFrameworkScaled   = 21,
    kHIWindowBitNoShadow          = 22,
    kHIWindowBitCanBeVisibleWithoutLogin = 23,
    kHIWindowBitAsyncDrag         = 24,
    kHIWindowBitHideOnSuspend     = 25,
    kHIWindowBitStandardHandler   = 26,
    kHIWindowBitHideOnFullScreen  = 27,
    kHIWindowBitInWindowMenu      = 28,
    kHIWindowBitLiveResize        = 29,
    kHIWindowBitIgnoreClicks      = 30,
    kHIWindowBitNoConstrain       = 32,
    kHIWindowBitDoesNotHide       = 33,
    kHIWindowBitAutoViewDragTracking = 34
}

enum : int
{
    kWindowNoAttributes           = 0,
    kWindowCloseBoxAttribute      = (1 << (kHIWindowBitCloseBox - 1)),
    kWindowHorizontalZoomAttribute = (1 << (kHIWindowBitZoomBox - 1)),
    kWindowVerticalZoomAttribute  = (1 << kHIWindowBitZoomBox),
    kWindowFullZoomAttribute      = (kWindowVerticalZoomAttribute | kWindowHorizontalZoomAttribute),
    kWindowCollapseBoxAttribute   = (1 << (kHIWindowBitCollapseBox - 1)),
    kWindowResizableAttribute     = (1 << (kHIWindowBitResizable - 1)),
    kWindowSideTitlebarAttribute  = (1 << (kHIWindowBitSideTitlebar - 1)),
    kWindowToolbarButtonAttribute = (1 << (kHIWindowBitToolbarButton - 1)),
    kWindowUnifiedTitleAndToolbarAttribute = (1 << (kHIWindowBitUnifiedTitleAndToolbar - 1)),
    kWindowMetalAttribute         = (1 << (kHIWindowBitTextured - 1)),
    kWindowNoTitleBarAttribute    = (1 << (kHIWindowBitNoTitleBar - 1)),
    kWindowTexturedSquareCornersAttribute = (1 << (kHIWindowBitTexturedSquareCorners - 1)),
    kWindowMetalNoContentSeparatorAttribute = (1 << (kHIWindowBitNoTexturedContentSeparator - 1)),
    kWindowHasRoundBottomBarCornersAttribute = (1 << (kHIWindowBitRoundBottomBarCorners - 1)),
    kWindowDoesNotCycleAttribute  = (1 << (kHIWindowBitDoesNotCycle - 1)),
    kWindowNoUpdatesAttribute     = (1 << (kHIWindowBitNoUpdates - 1)),
    kWindowNoActivatesAttribute   = (1 << (kHIWindowBitNoActivates - 1)),
    kWindowOpaqueForEventsAttribute = (1 << (kHIWindowBitOpaqueForEvents - 1)),
    kWindowCompositingAttribute   = (1 << (kHIWindowBitCompositing - 1)),
    kWindowNoShadowAttribute      = (1 << (kHIWindowBitNoShadow - 1)),
    kWindowCanBeVisibleWithoutLoginAttribute = (1 << (kHIWindowBitCanBeVisibleWithoutLogin - 1)),
    kWindowHideOnSuspendAttribute = (1 << (kHIWindowBitHideOnSuspend - 1)),
    kWindowAsyncDragAttribute     = (1 << (kHIWindowBitAsyncDrag - 1)),
    kWindowStandardHandlerAttribute = (1 << (kHIWindowBitStandardHandler - 1)),
    kWindowHideOnFullScreenAttribute = (1 << (kHIWindowBitHideOnFullScreen - 1)),
    kWindowInWindowMenuAttribute  = (1 << (kHIWindowBitInWindowMenu - 1)),
    kWindowLiveResizeAttribute    = (1 << (kHIWindowBitLiveResize - 1)),
    kWindowIgnoreClicksAttribute  = (1 << (kHIWindowBitIgnoreClicks - 1)),
    kWindowFrameworkScaledAttribute = (1 << (kHIWindowBitFrameworkScaled - 1)),
    kWindowStandardDocumentAttributes = (kWindowCloseBoxAttribute | kWindowFullZoomAttribute | kWindowCollapseBoxAttribute | kWindowResizableAttribute),
    kWindowStandardFloatingAttributes = (kWindowCloseBoxAttribute | kWindowCollapseBoxAttribute)
}


extern (C) nothrow @nogc
{
    alias da_GetWindowAttributes = OSStatus function(WindowRef window, WindowAttributes* outAttributes);
}

__gshared
{
    da_GetWindowAttributes GetWindowAttributes;
}

