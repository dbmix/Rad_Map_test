//
//  QTRViewController.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/29/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRViewController.h"
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

@interface QTRViewController ()

@property (strong, nonatomic) MKMapView *QTRView;
@property (strong, nonatomic) UIButton *QTRButton;

@end

@implementation QTRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.QTRView = [[MKMapView alloc] init];
    self.view = self.QTRView;
        //CLLocationCoordinate2D startCenter;
        //MKCoordinateSpan startSpan;
        //startCenter.latitude = 40.697488;
        // startCenter.longitude = -73.97968;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(
                                                                CLLocationCoordinate2DMake(24.2, 45.1), 2500000, 2500000);
    [self.QTRView setRegion:region animated:NO];


}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGRect scrn = [[UIScreen mainScreen] bounds];

    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) ||
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        self.QTRButton = [[UIButton alloc] initWithFrame:CGRectMake(30, scrn.size.height -320 , 120, 40)];
        NSLog(@"Button frame = %@", NSStringFromCGRect(self.QTRButton.frame));
    } else {
        self.QTRButton = [[UIButton alloc] initWithFrame:CGRectMake(30, scrn.size.height -50 , 120, 40)];
        NSLog(@"Button frame = %@", NSStringFromCGRect(self.QTRButton.frame));
    }


    self.QTRButton.backgroundColor = [UIColor whiteColor];
    [self.QTRButton setTitle:@"Qatar" forState:UIControlStateNormal];
    self.QTRButton.titleLabel.textColor = [UIColor blackColor];
    [self.QTRButton addTarget:self action:@selector(zoomToQatar) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.QTRButton];


}

-(void) zoomToQatar {
    NSLog(@"Button clicked");
    MKPointAnnotation *pt1 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(26.185, 51.21)];
    MKPointAnnotation *pt2 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(25.899, 51.68)];
    MKPointAnnotation *pt3 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(24.871, 51.76)];
    MKPointAnnotation *pt4 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(24.397, 51.22)];
    MKPointAnnotation *pt5 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(25.252, 50.73)];
    MKPointAnnotation *pt6 = [self createAnnotationAtCordinate:CLLocationCoordinate2DMake(25.795, 50.80)];
    CLLocationCoordinate2D ovrlayCoord [6];
    ovrlayCoord [0] = pt1.coordinate;
    ovrlayCoord [1] = pt2.coordinate;
    ovrlayCoord [2] = pt3.coordinate;
    ovrlayCoord [3] = pt4.coordinate;
    ovrlayCoord [4] = pt5.coordinate;
    ovrlayCoord [5] = pt6.coordinate;
    MKPolygon *demoPolygon = [MKPolygon polygonWithCoordinates:ovrlayCoord count:6];
    [self.QTRView addOverlay:demoPolygon level:MKOverlayLevelAboveRoads];//try using AboveLabels
                                                                         

    [self.QTRView showAnnotations:@[pt1,pt2,pt3,pt4,pt5,pt6] animated:YES];

}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
        //UIColor *purpleColor = [UIColor colorWithRed:0.149f green:0.0f blue:0.40f alpha:1.0f];
    UIColor *halfPurpleColor = [UIColor colorWithRed:0.149f green:0.0f blue:0.40f alpha:0.5f];
    UIColor *halfBlackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        //if(overlay ==stadiumsPolygon){
        MKPolygonRenderer *polygonRenderer = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
        polygonRenderer.strokeColor =halfBlackColor;
        polygonRenderer.fillColor =halfPurpleColor;
        return polygonRenderer;
}


-(MKPointAnnotation *)createAnnotationAtCordinate:(CLLocationCoordinate2D) coord{
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coord;
    return point;
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGRect btn = self.QTRButton.frame;
    CGRect scrn = [[UIScreen mainScreen] bounds];
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) ||
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        btn.origin.y = scrn.size.height - 320;
        NSLog(@"is landscape");
    } else {
        btn.origin.y = scrn.size.height - 50;
        NSLog(@"is portrait");
    }
    self.QTRButton.frame = btn;
    NSLog(@"Button frame = %@", NSStringFromCGRect(self.QTRButton.frame));
    self.QTRButton.hidden = NO;


}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    self.QTRButton.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
