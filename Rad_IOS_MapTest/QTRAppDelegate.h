//
//  QTRAppDelegate.h
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/29/13.
//  Copyright (c) 2013 db. All rights reserved.
//

    //#define IOS			defined(__IPHONE_OS_VERSION_MAX_ALLOWED)
#ifdef IS_IOS

#import <UIKit/UIKit.h>
@class QTRiOSViewController;

@interface QTRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) QTRiOSViewController *QTRMapController;

@end

#endif
