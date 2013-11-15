//
//  QTRStripesOverlayView.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 11/14/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRStripesOverlayView.h"
#import "QTRMacros.h"

@implementation QTRStripesOverlayView

    //#define H_PATTERN_SIZE 16

    //#define V_PATTERN_SIZE 18

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {

        // Get the overlay bounding rectangle.
    MKMapRect  theMapRect = [self.overlay boundingMapRect];
    CGRect theRect = [self rectForMapRect:theMapRect];


   /*     // !!!: : wha!

    CGPatternRef    pattern;// 1

    CGColorSpaceRef patternSpace;// 2

    CGFloat         alpha = 1;// 3

        //width, height;// 4

    static const    CGPatternCallbacks callbacks = {0, // 5

        &drawStripes,

        NULL};



    CGContextSaveGState (context);

    patternSpace = CGColorSpaceCreatePattern (NULL);// 6

    CGContextSetFillColorSpace (context, patternSpace);// 7

    CGColorSpaceRelease (patternSpace);// 8



    pattern = CGPatternCreate (NULL, // 9

                               CGRectMake (0, 0, theRect.size.width, theRect.size.height),// 10

                               CGAffineTransformMake (1, 0, 0, 1, 0, 0),// 11

                               H_PATTERN_SIZE, // 12

                               V_PATTERN_SIZE, // 13

                               kCGPatternTilingConstantSpacing,// 14

                               true, // 15
                               
                               &callbacks);// 16
    
    
    
    CGContextSetFillPattern (context, pattern, &alpha);// 17
    
    CGPatternRelease (pattern);// 18
    
    CGContextFillRect (context, theRect);// 19
    
    CGContextRestoreGState (context);




    CGContextSaveGState(context);

        // Clip the context to the bounding rectangle.
    CGContextAddRect(context, theRect);
    CGContextClip(context);

    CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(nil);
    CGContextSetFillColorSpace (context, sp2);
    CGColorSpaceRelease (sp2);
    CGPatternCallbacks callback = {
        0, drawStripes, nil
    };
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGPatternRef patt = CGPatternCreate(nil,
                                        CGRectMake(0,0,4,4),
                                        tr,
                                        4, 4,
                                        kCGPatternTilingConstantSpacingMinimalDistortion,
                                        true,
                                        &callback);
    CGFloat alph = 0.5;
    CGContextSetFillPattern(context, patt, &alph); */

        //CGContextFillRect(context, theRect);


        // Clip the context to the bounding rectangle.
    CGContextAddRect(context, theRect);
    CGContextClip(context);


       // Set up the gradient color and location information.

    CGColorSpaceRef myColorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[4] = {0.0, 0.33, 0.66, 1.0};
    CGFloat components[16] = {0.0, 0.0, 1.0, 0.5,
        1.0, 1.0, 1.0, 0.8,
        1.0, 1.0, 1.0, 0.8,
        0.0, 0.0, 1.0, 0.5};

        // Create the gradient.
    CGGradientRef myGradient = CGGradientCreateWithColorComponents(myColorSpace, components, locations, 4);
    CGPoint start, end;
    start = CGPointMake(CGRectGetMidX(theRect), CGRectGetMinY(theRect));
    end = CGPointMake(CGRectGetMidX(theRect), CGRectGetMaxY(theRect));

        // Draw.
    CGContextDrawLinearGradient(context, myGradient, start, end, 0);

        // Clean up.
    CGColorSpaceRelease(myColorSpace);
    CGGradientRelease(myGradient); 
        //CGColorSpaceRelease(sp2);
        //CGPatternRelease(patt);
        //CGContextRestoreGState(context);

}

void drawStripes (void *info, CGContextRef con) {
        // assume 4 x 4 cell
    CGContextSetFillColorWithColor(con, [[COLOR redColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0,0,4,4));
    CGContextSetFillColorWithColor(con, [[COLOR blueColor] CGColor]);
    CGContextFillRect(con, CGRectMake(0,0,4,2));
}





void MyDrawColoredPattern (void *info, CGContextRef myContext)

{

    CGFloat subunit = 5; // the pattern cell itself is 16 by 18



    CGRect  myRect1 = {{0,0}, {subunit, subunit}},

    myRect2 = {{subunit, subunit}, {subunit, subunit}},

    myRect3 = {{0,subunit}, {subunit, subunit}},

    myRect4 = {{subunit,0}, {subunit, subunit}};



    CGContextSetRGBFillColor (myContext, 0, 0, 1, 0.5);

    CGContextFillRect (myContext, myRect1);

    CGContextSetRGBFillColor (myContext, 1, 0, 0, 0.5);

    CGContextFillRect (myContext, myRect2);

    CGContextSetRGBFillColor (myContext, 0, 1, 0, 0.5);

    CGContextFillRect (myContext, myRect3);

    CGContextSetRGBFillColor (myContext, .5, 0, .5, 0.5);

    CGContextFillRect (myContext, myRect4);
    
}


@end
