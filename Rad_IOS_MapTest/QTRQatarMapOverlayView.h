//
//  QTRQatarMapOverlayView.h
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/30/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRMacros.h"
#import <MapKit/MapKit.h>

@interface QTRQatarMapOverlayView : MKOverlayRenderer

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(IMAGE *)overlayImage;

@end
