//
//  QTRQatarMapOverlay.h
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/30/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Qatar;

@interface QTRQatarMapOverlay : NSObject <MKOverlay>

- (instancetype)initWithRegion:(Qatar *)qatar;

@end
