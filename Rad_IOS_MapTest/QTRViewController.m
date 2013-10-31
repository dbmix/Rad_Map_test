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
#import "Qatar.h"
#import "QTRQatarMapOverlayView.h"
#import "QTRQatarMapOverlay.h"

@interface QTRViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *QTRView;
@property (strong, nonatomic) UIButton *QTRButton;
@property (strong, nonatomic) MKPolygon *demoPolygon;
@property (strong, nonatomic) MKPolygonRenderer *polyRender;
@property (strong, nonatomic) Qatar *qatar;
@property (strong, nonatomic) UIButton *QTRFlag;
@property (strong, nonatomic) QTRQatarMapOverlay *flagOverlay;

@end

@implementation QTRViewController

bool polyOverlay = NO;
bool graphicOverlay = NO;

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
    self.QTRView.delegate = self;

    self.qatar = [[Qatar alloc] initWithRegion];



}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGRect scrn = [[UIScreen mainScreen] bounds];

    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) ||
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        self.QTRButton = [[UIButton alloc] initWithFrame:CGRectMake(30, scrn.size.height -320 , 120, 40)];
        self.QTRFlag = [[UIButton alloc] initWithFrame:CGRectMake(180, scrn.size.height -320 , 120, 40)];
        NSLog(@"Button frame = %@", NSStringFromCGRect(self.QTRButton.frame));
    } else {
        self.QTRButton = [[UIButton alloc] initWithFrame:CGRectMake(30, scrn.size.height -50 , 120, 40)];
        self.QTRFlag = [[UIButton alloc] initWithFrame:CGRectMake(180, scrn.size.height -50 , 120, 40)];

        NSLog(@"Button frame = %@", NSStringFromCGRect(self.QTRButton.frame));
    }


    self.QTRButton.backgroundColor = [UIColor whiteColor];
    [self.QTRButton setTitle:@"Qatar" forState:UIControlStateNormal];
    [self.QTRButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.QTRButton.titleLabel.textColor = [UIColor blackColor];
    [self.QTRButton addTarget:self action:@selector(zoomToQatarWithAnnotations) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.QTRButton];

    self.QTRFlag.backgroundColor = [UIColor whiteColor];
    [self.QTRFlag setTitle:@"Flag" forState:UIControlStateNormal];
    [self.QTRFlag setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.QTRFlag.titleLabel.textColor = [UIColor blackColor];
    [self.QTRFlag addTarget:self action:@selector(addFlagOverlay) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.QTRFlag];


}

-(void) zoomToQatarWithAnnotations {

    self.QTRButton.selected = NO;
    if (polyOverlay) {
        [self.QTRView removeOverlay:self.demoPolygon];
        polyOverlay = NO;
        NSArray *annotationsOnMap = self.QTRView.annotations;
        if ([annotationsOnMap count] > 0) {
            [self.QTRView removeAnnotations:annotationsOnMap];
        }
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(
                                                                       CLLocationCoordinate2DMake(24.2, 45.1), 2500000, 2500000);
        [self.QTRView setRegion:region animated:YES];
        return;
    }
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
    self.demoPolygon = [MKPolygon polygonWithCoordinates:ovrlayCoord count:6];
    [self.QTRView addOverlay:self.demoPolygon level:MKOverlayLevelAboveRoads];
    polyOverlay = YES;
        //[self fadeTheAnnotationsAndOverlay];

    [self.QTRView showAnnotations:@[pt1,pt2,pt3,pt4,pt5,pt6] animated:YES];
    NSArray *annotationsOnMap = self.QTRView.annotations;
    if ([annotationsOnMap count] > 0) {
        [self.QTRView removeAnnotations:annotationsOnMap];
    }


        //[self fadeTheAnnotationsAndOverlay];

}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
        //UIColor *purpleColor = [UIColor colorWithRed:0.149f green:0.0f blue:0.40f alpha:1.0f];
    if ([overlay isKindOfClass:QTRQatarMapOverlay.class]) {
        UIImage *QFlag = [UIImage imageNamed:@"QFlag"];
        QTRQatarMapOverlayView *overlayView = [[QTRQatarMapOverlayView alloc] initWithOverlay:overlay overlayImage:QFlag];
        overlayView.alpha = 0.5;
        return overlayView;
    }

    UIColor *fillColor = [UIColor colorWithHue:.5 saturation:.5 brightness:.5 alpha:.5];
    UIColor *strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        self.polyRender = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
        self.polyRender.strokeColor =strokeColor;
        self.polyRender.fillColor =fillColor;
        return self.polyRender;
}

-(void)fadeTheAnnotationsAndOverlay {

        //[UIView animateWithDuration:0.6 animations:^{[self.QTRView removeOverlay:self.demoPolygon];} completion:^(BOOL finished) {}];
    [UIView animateWithDuration:2.0 delay:10 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.polyRender.fillColor = [UIColor colorWithHue:.5 saturation:.5 brightness:.5 alpha:.5];
        self.polyRender.strokeColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];} completion:^(BOOL finished) {
        ;}];

}


-(MKPointAnnotation *)createAnnotationAtCordinate:(CLLocationCoordinate2D) coord{
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coord;
    [[self.QTRView viewForAnnotation:point] setHidden:YES];
    return point;
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGRect btn = self.QTRButton.frame;
    CGRect btn2 = self.QTRFlag.frame;
    CGRect scrn = [[UIScreen mainScreen] bounds];
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) ||
        ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        btn.origin.y = btn2.origin.y = scrn.size.height - 320;
        NSLog(@"is landscape");
    } else {
        btn.origin.y = btn2.origin.y = scrn.size.height - 50;
        NSLog(@"is portrait");
    }
    self.QTRButton.frame = btn;
    self.QTRFlag.frame = btn2;
    NSLog(@"Button frame = %@", NSStringFromCGRect(self.QTRButton.frame));
    self.QTRButton.hidden = self.QTRFlag.hidden = NO;


}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    self.QTRButton.hidden = self.QTRFlag.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFlagOverlay {
    if (graphicOverlay) {
        [self.QTRView removeOverlay:self.flagOverlay];
        graphicOverlay = NO;
        return;
    }
    self.flagOverlay = [[QTRQatarMapOverlay alloc] initWithRegion:self.qatar];
    [self.QTRView addOverlay:self.flagOverlay level:MKOverlayLevelAboveRoads];
    graphicOverlay = YES;
}

/*
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:QTRQatarMapOverlay.class]) {
        UIImage *QFlag = [UIImage imageNamed:@"QFlag"];
        QTRQatarMapOverlayView *overlayView = [[QTRQatarMapOverlayView alloc] initWithOverlay:overlay overlayImage:QFlag];

        return overlayView;
    }

    return nil;
}

- (void)addBoundary {
    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:self.qatar.boundary
                                                     count:4];//self.qatar.boundaryPointsCount
    [self.QTRView addOverlay:polygon];
}
*/

@end
