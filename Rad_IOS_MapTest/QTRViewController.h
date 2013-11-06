//
//  QTRViewController.h
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/29/13.
//  Copyright (c) 2013 db. All rights reserved.
//


#import "QTRMacros.h"
#ifdef IS_IOS

#import <UIKit/UIKit.h>
#endif

#ifdef IS_OSX

#import <Foundation/Foundation.h>
#endif

#import <MapKit/MapKit.h>

@interface QTRViewController : VIEWCONTROLLER <MAPVIEWDELEGATE>

#ifdef IS_OSX

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil windowFrame:(NSRect)windowFrame;

#endif

@end
