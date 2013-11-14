//
//  QTRStripesMapOverlay.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 11/14/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRStripesMapOverlay.h"
#import "Qatar.h"

@implementation QTRStripesMapOverlay

@synthesize coordinate;
@synthesize boundingMapRect;

    //the object to initialize the overlay

- (instancetype)initWithRegion:(Qatar *)qatar {
    self = [super init];
    if (self) {
        boundingMapRect = qatar.overlayBoundingMapRect;
        coordinate = qatar.midCoordinate;
    }

    return self;
}

@end

