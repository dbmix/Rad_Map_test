    //
    //  QTRParkMapItem.m
    //  Rad_IOS_MapTest
    //
    //  Created by Developer Station 05 on 11/6/13.
    //  Copyright (c) 2013 db. All rights reserved.
    //


#import "QTRParkMapItem.h"

@implementation QTRParkMapItem

- (CLLocationCoordinate2D)coordinate
{
    coordinate.latitude = [self.latitude doubleValue];
    coordinate.longitude = [self.longitude doubleValue];
    return coordinate;
}

@end
