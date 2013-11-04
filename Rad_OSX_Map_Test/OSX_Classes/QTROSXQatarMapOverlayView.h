//
//  QTROSXQatarMapOverlayView.h
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/30/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface QTROSXQatarMapOverlayView : MKOverlayRenderer

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(NSImage *)overlayImage;

@end
