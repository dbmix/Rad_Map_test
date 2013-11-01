//
//  QTRStartingRegion.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 11/1/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRStartingRegion.h"


@implementation QTRStartingRegion

+(MKCoordinateRegion)startingRegion {

MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(
                                                               CLLocationCoordinate2DMake(24.2, 45.1), 2500000, 2500000);
    return region;
}
@end
