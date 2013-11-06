//
//  QTROSXViewController.m
//  Rad_OSX_Map_test
//
//  Created by Developer Station 05 on 10/30/13.
//  Copyright (c) 2013 db. All rights reserved.
//


#import "QTROSXViewController.h"
#import <MapKit/MapKit.h>
    //#import <AddressBook/AddressBook.h>
#import "Qatar.h"
#import "QTRQatarMapOverlayView.h"
#import "QTRQatarMapOverlay.h"
#import "QTRStartingRegion.h"

@interface QTROSXViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *QTRView;
@property (strong, nonatomic) NSButton *QTRButton;
@property (strong, nonatomic) MKPolygon *demoPolygon;
@property (strong, nonatomic) MKPolygonRenderer *polyRender;
@property (strong, nonatomic) Qatar *qatar;
@property (strong, nonatomic) NSButton *QTRFlag;
@property (strong, nonatomic) NSButton *Doha;
@property (strong, nonatomic) QTRQatarMapOverlay *flagOverlay;
@property (strong, nonatomic) NSDictionary *viewsDictionary;

@end

@implementation QTROSXViewController

bool polyOverlay = NO;
bool graphicOverlay = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil windowFrame:(NSRect)windowFrame
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
            // Initialization code here.
            //self.QTRView = [[MKMapView alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0.0, 0.0, 400, 400))];
        self.QTRView = [[MKMapView alloc] initWithFrame:windowFrame];
        self.QTRView.showsUserLocation = NO;

        self.view = self.QTRView;
        MKCoordinateRegion region = [QTRStartingRegion startingRegion];
        [self.QTRView setRegion:region animated:NO];
        self.QTRView.delegate = self;

        self.qatar = [[Qatar alloc] initWithRegion];
        self.QTRButton = [[NSButton alloc] initWithFrame:CGRectMake(30, 50 , 120, 40)];
        self.QTRFlag = [[NSButton alloc] initWithFrame:CGRectMake(180, 50 , 120, 40)];
        self.Doha = [[NSButton alloc] initWithFrame:CGRectMake(320,050,120,40)];
        [self.QTRButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.QTRFlag setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.Doha setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.QTRButton setTitle:@"Qatar"];
        [self.QTRButton setAction:@selector(zoomToQatarWithAnnotations)];
        [self.view addSubview:self.QTRButton];
        [self.QTRFlag setTitle:@"Flag"];
        [self.QTRFlag setAction:@selector(addFlagOverlay)];
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
    return self;
}


-(void) zoomToQatarWithAnnotations {

        //self.QTRButton.selected = NO;
    if (polyOverlay) {
        [self.QTRView removeOverlay:self.demoPolygon];
        polyOverlay = NO;
        NSArray *annotationsOnMap = self.QTRView.annotations;
        if ([annotationsOnMap count] > 0) {
            [self.QTRView removeAnnotations:annotationsOnMap];
        }
        MKCoordinateRegion region = [QTRStartingRegion startingRegion];
        [self.QTRView setRegion:region animated:YES];
        [self.QTRButton setTitle:@"Qatar"];
        self.Doha.hidden = YES;
        return;
    }
    NSArray *outLineCoordinates = [self.qatar qatarOutlineCoordinates];
    int nmbr = (int)[outLineCoordinates count];
    CLLocationCoordinate2D ovrlayCoord [(int)[outLineCoordinates count]];
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
    [self.Doha setTitle:@"Doha"];
     [self.Doha setAction:@selector(mapDoha)];
    self.Doha.hidden = NO;
     [self.QTRButton setTitle:@"Region"];
}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
        //UIColor *purpleColor = [UIColor colorWithRed:0.149f green:0.0f blue:0.40f alpha:1.0f];
    if ([overlay isKindOfClass:QTRQatarMapOverlay.class]) {
        NSImage *QFlag = [NSImage imageNamed:@"QFlag"];
        QTRQatarMapOverlayView *overlayView = [[QTRQatarMapOverlayView alloc] initWithOverlay:overlay overlayImage:QFlag];
        overlayView.alpha = 0.5;
        return overlayView;
    }

    NSColor *fillColor = [NSColor colorWithHue:.5 saturation:.5 brightness:.5 alpha:.5];
    NSColor *strokeColor = [NSColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    self.polyRender = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
    self.polyRender.strokeColor =strokeColor;
    self.polyRender.fillColor =fillColor;
    return self.polyRender;
}


/*
-(MKPointAnnotation *)createAnnotationAtCordinate:(CLLocationCoordinate2D) coord{
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coord;
    [[self.QTRView viewForAnnotation:point] setHidden:YES];
    return point;
}
*/

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
