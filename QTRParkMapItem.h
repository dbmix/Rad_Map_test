    //
    //  QTRParkMapItem.h
    //  Rad_IOS_MapTest
    //
    //  Created by Developer Station 05 on 11/6/13.
    //  Copyright (c) 2013 db. All rights reserved.
    //

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface QTRParkMapItem : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
}


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end
