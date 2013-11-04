//
//  QTROSXQatarMapOverlayView.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/30/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTROSXQatarMapOverlayView.h"


@interface QTROSXQatarMapOverlayView ()

@property (nonatomic, strong) NSImage *overlayImage;

@end

@implementation QTROSXQatarMapOverlayView

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(NSImage *)overlayImage {
    self = [super initWithOverlay:overlay];
    if (self) {
        _overlayImage = overlayImage;
    }

    return self;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {
        //CGImageRef imageReference = (__bridge CGImageRef)(self.overlayImage);


    MKMapRect theMapRect = self.overlay.boundingMapRect;
    NSRect theRect = NSRectFromCGRect([self rectForMapRect:theMapRect]);
    CGImageRef imageReference = [self.overlayImage CGImageForProposedRect:&theRect context:(__bridge NSGraphicsContext *)(context) hints:nil];

    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -theRect.size.height);
    CGContextDrawImage(context, theRect, imageReference);
}

@end
