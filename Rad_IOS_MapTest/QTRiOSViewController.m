//
//  QTRiOSViewController.m
//  Rad_IOS_MapTest
//
//  Created by Developer Station 05 on 10/29/13.
//  Copyright (c) 2013 db. All rights reserved.
//

#import "QTRiOSViewController.h"
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import "Qatar.h"
#import "QTRiOSQatarMapOverlayView.h"
#import "QTRQatarMapOverlay.h"
#import "QTRStartingRegion.h"

@interface QTRiOSViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *QTRView;
@property (strong, nonatomic) UIButton *QTRButton;
@property (strong, nonatomic) MKPolygon *demoPolygon;
@property (strong, nonatomic) MKPolygonRenderer *polyRender;
@property (strong, nonatomic) Qatar *qatar;
@property (strong, nonatomic) UIButton *QTRFlag;
@property (strong, nonatomic) QTRQatarMapOverlay *flagOverlay;
@property (strong, nonatomic) UIButton *Doha;
@property (strong, nonatomic) NSDictionary *viewsDictionary;

@end

@implementation QTRiOSViewController

bool polyOverlay = NO;
bool graphicOverlay = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.QTRView = [[MKMapView alloc] init];
    self.QTRView.showsUserLocation = NO;
    self.view = self.QTRView;
    MKCoordinateRegion region = [QTRStartingRegion startingRegion];
    [self.QTRView setRegion:region animated:NO];
    self.QTRView.delegate = self;

    self.qatar = [[Qatar alloc] initWithRegion];





}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
        //CGRect scrn = [[UIScreen mainScreen] bounds];

        //if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) ||
        //([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        //self.QTRButton = [[UIButton alloc] initWithFrame:CGRectMake(30, scrn.size.height -320 , 120, 40)];
    self.QTRButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.QTRButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        //self.QTRFlag = [[UIButton alloc] initWithFrame:CGRectMake(180, scrn.size.height -320 , 120, 40)];
    self.QTRFlag = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.QTRFlag setTranslatesAutoresizingMaskIntoConstraints:NO];

    self.Doha = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.Doha setTranslatesAutoresizingMaskIntoConstraints:NO];
        //NSLog(@"Button frame = %@", NSStringFromCGRect(self.QTRButton.frame));
        //} else {
        //self.QTRButton = [[UIButton alloc] initWithFrame:CGRectMake(30, scrn.size.height -50 , 120, 40)];
        //self.QTRFlag = [[UIButton alloc] initWithFrame:CGRectMake(180, scrn.size.height -50 , 120, 40)];

        // NSLog(@"Button frame = %@", NSStringFromCGRect(self.QTRButton.frame));
        //}


    self.QTRButton.backgroundColor = [UIColor whiteColor];
    [self.QTRButton setTitle:@"Qatar" forState:UIControlStateNormal];
    [self.QTRButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //self.QTRButton.titleLabel.textColor = [UIColor blackColor];
    [self.QTRButton addTarget:self action:@selector(zoomToQatarWithAnnotations) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.QTRButton];

    self.QTRFlag.backgroundColor = [UIColor whiteColor];
    [self.QTRFlag setTitle:@"Flag" forState:UIControlStateNormal];
    [self.QTRFlag setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //self.QTRFlag.titleLabel.textColor = [UIColor blackColor];
    [self.QTRFlag addTarget:self action:@selector(addFlagOverlay) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.QTRFlag];
    [self.view addSubview:self.Doha];
    self.Doha.hidden = YES;
        //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_QTRButton, _QTRFlag, _Doha);
    _viewsDictionary = NSDictionaryOfVariableBindings(_QTRButton, _QTRFlag, _Doha);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_QTRButton]" options:0 metrics:nil views:_viewsDictionary];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_QTRButton]-30-|" options:0 metrics:nil views:_viewsDictionary]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[_QTRButton(>=100)]" options:0 metrics:nil views:_viewsDictionary]];


    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_QTRButton]-30-[_QTRFlag]" options:0 metrics:nil views:_viewsDictionary]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_QTRFlag]-30-|" options:0 metrics:nil views:_viewsDictionary]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[_QTRFlag(>=100)]" options:0 metrics:nil views:_viewsDictionary]];

    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_QTRFlag]-30-[_Doha]" options:0 metrics:nil views:_viewsDictionary]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_Doha]-30-|" options:0 metrics:nil views:_viewsDictionary]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[_Doha(>=100)]" options:0 metrics:nil views:_viewsDictionary]];

    [self.view addConstraints:constraints];



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
        MKCoordinateRegion region = [QTRStartingRegion startingRegion];
        [self.QTRView setRegion:region animated:YES];
        [self.QTRButton setTitle:@"Qatar" forState:UIControlStateNormal];
        self.Doha.hidden = YES;
        return;
    }
    NSArray *outLineCoordinates = [self.qatar qatarOutlineCoordinates];
    int nmbr = [outLineCoordinates count];
    CLLocationCoordinate2D ovrlayCoord [nmbr];
    for (int i=0; i<nmbr; i++) {
        ovrlayCoord[i] = [(MKPointAnnotation *)outLineCoordinates[i] coordinate];
    }

    self.demoPolygon = [MKPolygon polygonWithCoordinates:ovrlayCoord count:nmbr];
    [self.QTRView addOverlay:self.demoPolygon level:MKOverlayLevelAboveRoads];
    polyOverlay = YES;

    [self.QTRView showAnnotations:outLineCoordinates animated:YES];
    NSArray *annotationsOnMap = self.QTRView.annotations;
    if ([annotationsOnMap count] > 0) {
        [self.QTRView removeAnnotations:annotationsOnMap];
    }
        //CGRect flagButton = self.QTRFlag.frame;
        //self.Doha = [[UIButton alloc] initWithFrame:CGRectMake(330, flagButton.origin.y , 120, 40)];
    self.Doha.backgroundColor = [UIColor whiteColor];
    [self.Doha setTitle:@"Doha" forState:UIControlStateNormal];
    [self.Doha setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //self.Doha.titleLabel.textColor = [UIColor blackColor];
    [self.Doha addTarget:self action:@selector(mapDoha) forControlEvents:UIControlEventTouchDown];
    self.Doha.hidden = NO;
    [self.QTRButton setTitle:@"Region" forState:UIControlStateNormal];





}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if ([overlay isKindOfClass:QTRQatarMapOverlay.class]) {
        UIImage *QFlag = [UIImage imageNamed:@"QFlag"];
        QTRiOSQatarMapOverlayView *overlayView = [[QTRiOSQatarMapOverlayView alloc] initWithOverlay:overlay overlayImage:QFlag];
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

- (void) mapDoha {
    NSLog(@" mapping Doha now");

}
@end
