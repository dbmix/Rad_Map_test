//
//  QTRAppDelegate.m
//  Rad_OSX_Map_Test
//
//  Created by Developer Station 05 on 11/4/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRAppDelegate.h"
#import "QTROSXViewController.h"
#import <MapKit/MapKit.h>


@implementation QTRAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application

    [self.window setFrame:NSRectFromCGRect(CGRectMake(300, 300, 1000, 1000)) display:YES];
    NSRect windoh = self.window.frame;
    self.QTRMapController = [[QTROSXViewController alloc] initWithNibName:nil bundle:nil windowFrame:windoh];
    windoh.origin.x = windoh.origin.y = 0;
    self.QTRMapController.view.frame = windoh;
    [self.window.contentView addSubview:self.QTRMapController.view];
    self.window.delegate = self.QTRMapController;

}

@end
