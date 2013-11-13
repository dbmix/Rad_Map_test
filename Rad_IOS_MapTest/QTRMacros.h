//
//  QTRMacros.h
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 11/6/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef IS_IOS
#define APP_CLASS UIResponder
#define APP_DELEGATE UIApplicationDelegate
#define WINDOW UIWindow
#define MAPVIEWCONTROLLER QTRViewController
#define BUTTON UIButton
#define VIEWCONTROLLER UIViewController
#define MAPVIEWDELEGATE MKMapViewDelegate
#define IMAGE UIImage
#define COLOR UIColor
#define IMAGEVIEW UIImageView
#define LABEL UILabel
#define BACKGROUND self.backgroundColor
#define FONT UIFont
#define BEZIERPATH UIBezierPath

#endif

#ifdef IS_OSX
#define APP_CLASS NSObject
#define APP_DELEGATE NSApplicationDelegate
#define WINDOW NSWindow
#define MAPVIEWCONTROLLER QTRViewController
#define BUTTON NSButton
#define VIEWCONTROLLER NSViewController
#define MAPVIEWDELEGATE NSWindowDelegate
#define IMAGE NSImage
#define COLOR NSColor
#define IMAGEVIEW NSImageView
#define LABEL NSTextField
    //#define LABEL NSButton
#define BACKGROUND self.window.backgroundColor
#define FONT NSFont
#define BEZIERPATH NSBezierPath

#endif
