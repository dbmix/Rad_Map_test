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
        //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_QTRMapController.view, _window.contentView);
    NSDictionary *views = @{@"contentView": self.window.contentView, @"mapView": self.QTRMapController.view};
    [self.QTRMapController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[mapView]-5-|" options:0 metrics:nil views:views];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[mapView]-5-|" options:0 metrics:nil views:views]];
    [self.window.contentView addConstraints:constraints];
    self.window.delegate = self.QTRMapController;

}

@end
