//
//  QTRParks.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 11/6/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRParks.h"
#import "QTRParkMapItem.h"


@implementation QTRParks


    // class to hold parks in Doha data


-(NSArray *) arrayOfParks {
    NSMutableArray *parks = [NSMutableArray new];

    QTRParkMapItem *item1 = [[QTRParkMapItem alloc] init];
    item1.name = @"Al Muntazah Park";
    item1.image = @"AlMuntazah.jpg";
    item1.latitude = [NSNumber numberWithDouble:25.2653];
    item1.longitude = [NSNumber numberWithDouble:51.5238];
    [parks addObject:item1];

    QTRParkMapItem *item2 = [[QTRParkMapItem alloc] init];
    item2.name = @"Al Bidda Park";
    item2.image = @"Al_Bidda_Park.jpg";
    item2.latitude = [NSNumber numberWithDouble:25.3014];
    item2.longitude = [NSNumber numberWithDouble:51.5175];
    [parks addObject:item2];

    QTRParkMapItem *item3 = [[QTRParkMapItem alloc] init];
    item3.name = @"Salata Park";
    item3.image = @"Salata_Park.jpg";
    item3.latitude = [NSNumber numberWithDouble:25.2901];
    item3.longitude = [NSNumber numberWithDouble:51.5476];
    [parks addObject:item3];

    QTRParkMapItem *item4 = [[QTRParkMapItem alloc] init];
    item4.name = @"Al Ghanim Al Qadeem Park";
    item4.image = @"Al_Ghanim_Al_Qadeem.jpg";
    item4.latitude = [NSNumber numberWithDouble:25.2187];
    item4.longitude = [NSNumber numberWithDouble:51.5409];
    [parks addObject:item4];

    QTRParkMapItem *item5 = [[QTRParkMapItem alloc] init];
    item5.name = @"Al Khulaifat Park";
    item5.image = @"Al_Khulaifat.jpg";
    item5.latitude = [NSNumber numberWithDouble:25.2547];
    item5.longitude = [NSNumber numberWithDouble:51.5034];
    [parks addObject:item5];

    QTRParkMapItem *item6 = [[QTRParkMapItem alloc] init];
    item6.name = @"Aspire Park";
    item6.image = @"Aspire.jpg";
    item6.latitude = [NSNumber numberWithDouble:25.2599];
    item6.longitude = [NSNumber numberWithDouble:51.4350];
    [parks addObject:item6];

    return parks;
}



@end
 /* park locations
Al Muntazah Park
  25.2653
  51.5238
  AlMuntazah.jpg
  
Al Bidda Park
  25.3014
  51.5175
  Al_Bidda_Park.jpg
  
Salata Park
  25.2901
  51.5476
  Salata_Park.jpg

Al Ghanim Al Qadeem Park
  25.2187
  51.5409
Al_Ghanim_Al_Qadeem.jpg
  
Al Khulaifat Park
  25.2547
  51.5034
  Al_Khulaifat.jpg
  
Aspire Park
  25.2599
  51.4350
  Aspire.jpg

*/