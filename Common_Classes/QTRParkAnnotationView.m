//
//  QTRParkAnnotationView.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 11/6/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRMacros.h"
#import "QTRParkAnnotationView.h"
#import "QTRParkMapItem.h"
//#ifdef IS_OSX
//#define _annotationLabel _annotationLabel.textField
//#endif


static CGFloat kMaxViewWidth = 150.0;

static CGFloat kViewWidth = 90;
static CGFloat kViewLength = 100;

static CGFloat kLeftMargin = 15.0;
static CGFloat kRightMargin = 5.0;
static CGFloat kTopMargin = 5.0;
static CGFloat kBottomMargin = 10.0;
static CGFloat kRoundBoxLeft = 10.0;

@interface QTRParkAnnotationView ()
@property (nonatomic, strong) LABEL *annotationLabel;
@property (nonatomic, strong) IMAGEVIEW *annotationImage;
@end

@implementation QTRParkAnnotationView

    // determine the MKAnnotationView based on the annotation info and reuseIdentifier
    //
- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil)
        {

        BACKGROUND = [COLOR clearColor];

            // offset the annotation so it won't obscure the actual lat/long location
        self.centerOffset = CGPointMake(50.0, 50.0);

            // add the annotation's label
        self.annotationLabel = [[LABEL alloc] initWithFrame:CGRectZero];
        QTRParkMapItem *mapItem = (QTRParkMapItem*)self.annotation;
        _annotationLabel.font = [FONT systemFontOfSize:9.0];
        _annotationLabel.textColor = [COLOR whiteColor];
#ifdef IS_IOS
        self.annotationLabel.text = mapItem.name;
#endif
#ifdef IS_OSX
        [self.annotationLabel setStringValue:mapItem.name];
#endif
        [_annotationLabel sizeToFit];   // get the right vertical size


            // compute the optimum width of our annotation, based on the size of our annotation label
        CGFloat optimumWidth = self.annotationLabel.frame.size.width + kRightMargin + kLeftMargin;
        CGRect frame = self.frame;
        if (optimumWidth < kViewWidth)
            frame.size = CGSizeMake(kViewWidth, kViewLength);
        else if (optimumWidth > kMaxViewWidth)
            frame.size = CGSizeMake(kMaxViewWidth, kViewLength);
        else
            frame.size = CGSizeMake(optimumWidth, kViewLength);
        self.frame = frame;

            //self.annotationLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _annotationLabel.backgroundColor = [COLOR clearColor];
        CGRect newFrame = self.annotationLabel.frame;
        newFrame.origin.x = kLeftMargin;
        newFrame.origin.y = kTopMargin;
        newFrame.size.width = self.frame.size.width - kRightMargin - kLeftMargin;
        self.annotationLabel.frame = newFrame;
        [self addSubview:self.annotationLabel];

            // add the annotation's image
            // the annotation image snaps to the width and height of this view
#ifdef IS_IOS
        _annotationImage = [[IMAGEVIEW alloc] initWithImage:[IMAGE imageNamed:mapItem.image]];
        _annotationImage.contentMode = UIViewContentModeScaleAspectFit;
#endif
#ifdef IS_OSX
        _annotationImage = [[IMAGEVIEW alloc] init];
            //NSImage *img = [[NSImage alloc] initWithContentsOfFile:mapItem.image];
        [_annotationImage setImage:[[NSImage alloc] initWithContentsOfFile:mapItem.image]];
#endif


        _annotationImage.frame =
        CGRectMake(kLeftMargin,
                   self.annotationLabel.frame.origin.y + self.annotationLabel.frame.size.height + kTopMargin,
                   self.frame.size.width - kRightMargin - kLeftMargin,
                   self.frame.size.height - self.annotationLabel.frame.size.height - kTopMargin*2 - kBottomMargin);
        [self addSubview:_annotationImage];
        }

    return self;
}

- (void)setAnnotation:(id <MKAnnotation>)annotation
{
    [super setAnnotation:annotation];

        // this annotation view has custom drawing code.  So when we reuse an annotation view
        // (through MapView's delegate "dequeueReusableAnnoationViewWithIdentifier" which returns non-nil)
        // we need to have it redraw the new annotation data.
        //
        // for any other custom annotation view which has just contains a simple image, this won't be needed
        //
        //[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    QTRParkMapItem *mapItem = (QTRParkMapItem *)self.annotation;
    if (mapItem != nil)
        {
        [[COLOR darkGrayColor] setFill];

            // draw the pointed shape
        BEZIERPATH *pointShape = [BEZIERPATH bezierPath];
        [pointShape moveToPoint:CGPointMake(14.0, 0.0)];
#ifdef IS_IOS
        [pointShape addLineToPoint:CGPointMake(0.0, 0.0)];
        [pointShape addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
#endif
#ifdef IS_OSX
        [pointShape lineToPoint:NSPointFromCGPoint(CGPointMake(0.0, 0.0))];
        [pointShape lineToPoint:NSPointFromCGPoint(CGPointMake(self.frame.size.width, self.frame.size.height))];
#endif
        [pointShape fill];

            // draw the rounded box
#ifdef IS_IOS
        BEZIERPATH *roundedRect =
        [BEZIERPATH bezierPathWithRoundedRect:
         CGRectMake(kRoundBoxLeft, 0.0, self.frame.size.width - kRoundBoxLeft, self.frame.size.height) cornerRadius:3.0];
#endif
#ifdef IS_OSX
        BEZIERPATH *roundedRect =
        [BEZIERPATH bezierPathWithRoundedRect:NSRectFromCGRect(CGRectMake(kRoundBoxLeft, 0.0, self.frame.size.width - kRoundBoxLeft, self.frame.size.height)) xRadius:3.0 yRadius:3.0];
#endif


        roundedRect.lineWidth = 2.0;
        [roundedRect fill];
        }
}

@end

