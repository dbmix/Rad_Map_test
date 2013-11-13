//
//  QatarMapOverlay.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/30/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "Qatar.h"


@implementation Qatar

    //class to hold overlay data


- (instancetype)initWithRegion{

        self = [super init];
        if (self) {

            _midCoordinate = CLLocationCoordinate2DMake(25.304, 51.26);

            _overlayTopLeftCoordinate = CLLocationCoordinate2DMake(26.197, 50.60);


            _overlayTopRightCoordinate = CLLocationCoordinate2DMake(26.215, 51.89);

            _overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(24.352, 50.60);


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

- (NSArray *) qatarOutlineCoordinates {
    MKPointAnnotation *pt1 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(26.185, 51.21)];
    MKPointAnnotation *pt2 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(25.899, 51.68)];
    MKPointAnnotation *pt3 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(24.871, 51.76)];
    MKPointAnnotation *pt4 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(24.397, 51.22)];
    MKPointAnnotation *pt5 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(25.252, 50.73)];
    MKPointAnnotation *pt6 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(25.795, 50.80)];
    NSArray *outLineCoordinates = @[pt1, pt2, pt3, pt4, pt5, pt6];
    return outLineCoordinates;

}

-(MKPointAnnotation *)createAnnotationAtCordinate:(CLLocationCoordinate2D) coord{
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coord;
        //[[self.QTRView viewForAnnotation:point] setHidden:YES];
    return point;
}


@end

