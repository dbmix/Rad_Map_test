//
//  QatarMapOverlay.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/30/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "Qatar.h"


@implementation Qatar


- (instancetype)initWithRegion{

        self = [super init];
        if (self) {

            _midCoordinate = CLLocationCoordinate2DMake(25.304, 51.26);

            _overlayTopLeftCoordinate = CLLocationCoordinate2DMake(26.197, 50.60);


            _overlayTopRightCoordinate = CLLocationCoordinate2DMake(26.215, 51.89);

            _overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(24.352, 50.60);


            /*
            NSArray *boundaryPoints = properties[@"boundary"];

            _boundaryPointsCount = boundaryPoints.count;

            _boundary = malloc(sizeof(CLLocationCoordinate2D)*_boundaryPointsCount);

            for(int i = 0; i < _boundaryPointsCount; i++) {
                CGPoint p = CGPointFromString(boundaryPoints[i]);
                _boundary[i] = CLLocationCoordinate2DMake(p.x,p.y);
            } */
        }
        
        return self;
}

- (CLLocationCoordinate2D)overlayBottomRightCoordinate {
    return CLLocationCoordinate2DMake(self.overlayBottomLeftCoordinate.latitude, self.overlayTopRightCoordinate.longitude);
}

- (MKMapRect)overlayBoundingMapRect {

    MKMapPoint topLeft = MKMapPointForCoordinate(self.overlayTopLeftCoordinate);
    MKMapPoint topRight = MKMapPointForCoordinate(self.overlayTopRightCoordinate);
    MKMapPoint bottomLeft = MKMapPointForCoordinate(self.overlayBottomLeftCoordinate);

    return MKMapRectMake(topLeft.x,
                         topLeft.y,
                         fabs(topLeft.x - topRight.x),
                         fabs(topLeft.y - bottomLeft.y));
}

@end

