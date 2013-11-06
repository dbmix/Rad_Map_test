//
//  QTRAppDelegate.h
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/29/13.
//  Copyright (c) 2013 db. All rights reserved.
//

    //#define IOS			defined(__IPHONE_OS_VERSION_MAX_ALLOWED)

#import "QTRMacros.h"

#ifdef IS_IOS
#import <UIKit/UIKit.h>
#endif

#ifdef IS_OSX

#import <Cocoa/Cocoa.h>
#endif

@class MAPVIEWCONTROLLER;

@interface QTRAppDelegate : APP_CLASS <APP_DELEGATE>

@property (strong, nonatomic) WINDOW *window;
@property (strong, nonatomic) MAPVIEWCONTROLLER *QTRMapController;

@end

