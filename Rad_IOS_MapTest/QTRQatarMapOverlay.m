//
//  QTRQatarMapOverlay.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/30/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRQatarMapOverlay.h"
#import "Qatar.h"

@implementation QTRQatarMapOverlay

@synthesize coordinate;
@synthesize boundingMapRect;

- (instancetype)initWithRegion:(Qatar *)qatar {
    self = [super init];
    if (self) {
        boundingMapRect = qatar.overlayBoundingMapRect;
        coordinate = qatar.midCoordinate;
    }

    return self;
}

@end
