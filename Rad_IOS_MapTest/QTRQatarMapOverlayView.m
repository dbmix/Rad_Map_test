//
//  QTRQatarMapOverlayView.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/30/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRQatarMapOverlayView.h"

@interface QTRQatarMapOverlayView ()

@property (nonatomic, strong) IMAGE *overlayImage;

@end

@implementation QTRQatarMapOverlayView

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(IMAGE *)overlayImage {
    self = [super initWithOverlay:overlay];
    if (self) {
        _overlayImage = overlayImage;
    }

    return self;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {

    MKMapRect theMapRect = self.overlay.boundingMapRect;

#ifdef IS_IOS
    CGRect theRect = [self rectForMapRect:theMapRect];
    CGImageRef imageReference = self.overlayImage.CGImage;
#endif
#ifdef IS_OSX
    NSRect theRect = NSRectFromCGRect([self rectForMapRect:theMapRect]);
    CGImageRef imageReference = [self.overlayImage CGImageForProposedRect:&theRect context:(__bridge NSGraphicsContext *)(context) hints:nil];
#endif

    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -theRect.size.height);
    CGContextDrawImage(context, theRect, imageReference);
}

@end
