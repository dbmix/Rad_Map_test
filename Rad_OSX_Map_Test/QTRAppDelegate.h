//
//  QTRAppDelegate.h
//  Rad_OSX_Map_Test
//
//  Created by Developer Station 05 on 11/4/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class QTROSXViewController;
@class MKMapView;

@interface QTRAppDelegate : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) NSWindow *window;
@property (strong, nonatomic) QTROSXViewController *QTRMapController;
@property (weak) IBOutlet MKMapView *mapView;

@end
