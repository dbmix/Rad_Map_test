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
#import "QTRStartingRegion.h"
#import "QTRParks.h"
#import "QTRParkMapItem.h"
#import "QTRParkAnnotationView.h"

@interface QTRViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *QTRView;
@property (strong, nonatomic) BUTTON *QTRButton;
@property (strong, nonatomic) MKPolygon *demoPolygon;
@property (strong, nonatomic) MKPolygonRenderer *polyRender;
@property (strong, nonatomic) Qatar *qatar;
@property (strong, nonatomic) BUTTON *QTRFlag;
@property (strong, nonatomic) QTRQatarMapOverlay *flagOverlay;
@property (strong, nonatomic) BUTTON *Doha;
@property (strong, nonatomic) NSDictionary *viewsDictionary;

@end

@implementation QTRViewController

bool polyOverlay = NO;
bool graphicOverlay = NO;
bool mappingDoha = NO;

#ifdef IS_OSX
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil windowFrame:(NSRect)windowFrame
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
            // Initialization code here.
        self.QTRView = [[MKMapView alloc] initWithFrame:windowFrame];

        self.QTRButton = [[NSButton alloc] initWithFrame:CGRectMake(30, 50 , 120, 40)];
        self.QTRFlag = [[NSButton alloc] initWithFrame:CGRectMake(180, 50 , 120, 40)];
        self.Doha = [[NSButton alloc] initWithFrame:CGRectMake(320,050,120,40)];
        [self createInitialMap];

        [self.QTRButton setTitle:@"Qatar"];
        [self.QTRButton setAction:@selector(zoomToQatarWithAnnotations)];

        [self.QTRFlag setTitle:@"Flag"];
        [self.QTRFlag setAction:@selector(addFlagOverlay)];

        [self.Doha setTitle:@"Doha"];
        [self.Doha setAction:@selector(mapDoha)];
        [self addButtonsAndConstraints];


        
        
    }
    return self;
}
#endif  // end of OS X initiator

#ifdef IS_IOS
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.QTRView = [[MKMapView alloc] init];

    [self createInitialMap];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.QTRButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.QTRFlag = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.Doha = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    self.QTRButton.backgroundColor = [UIColor whiteColor];
    [self.QTRButton setTitle:@"Qatar" forState:UIControlStateNormal];
    [self.QTRButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.QTRButton addTarget:self action:@selector(zoomToQatarWithAnnotations) forControlEvents:UIControlEventTouchDown];


    self.QTRFlag.backgroundColor = [UIColor whiteColor];
    [self.QTRFlag setTitle:@"Flag" forState:UIControlStateNormal];
    [self.QTRFlag setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.QTRFlag addTarget:self action:@selector(addFlagOverlay) forControlEvents:UIControlEventTouchDown];

    self.Doha.backgroundColor = [UIColor whiteColor];
    [self.Doha setTitle:@"Doha" forState:UIControlStateNormal];
    [self.Doha setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.Doha addTarget:self action:@selector(mapDoha) forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:self.QTRButton];
    [self.view addSubview:self.QTRFlag];
    [self.view addSubview:self.Doha];

    [self addButtonsAndConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

#endif // end of IOS life cycle

-(void) createInitialMap
{
    self.QTRView.showsUserLocation = NO;
    self.view = self.QTRView;
    MKCoordinateRegion region = [QTRStartingRegion startingRegion];
    [self.QTRView setRegion:region animated:NO];
    self.QTRView.delegate = self;

    self.qatar = [[Qatar alloc] initWithRegion];
}

-(void) addButtonsAndConstraints
{
    [self.view addSubview:self.QTRButton];
    [self.view addSubview:self.QTRFlag];
    [self.view addSubview:self.Doha];
    self.Doha.hidden = YES;
    [self.QTRButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.QTRFlag setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.Doha setTranslatesAutoresizingMaskIntoConstraints:NO];
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

#pragma mark - map actions
-(void) zoomToQatarWithAnnotations {

    if (polyOverlay) {
        [self.QTRView removeOverlay:self.demoPolygon];
        polyOverlay = NO;
        NSArray *annotationsOnMap = self.QTRView.annotations;
        if ([annotationsOnMap count] > 0) {
            [self.QTRView removeAnnotations:annotationsOnMap];
        }
        MKCoordinateRegion region = [QTRStartingRegion startingRegion];
        [self.QTRView setRegion:region animated:YES];
            //[self.QTRButton setTitle:@"Qatar" forState:UIControlStateNormal];
        [self buttonTitle:self.QTRButton title:@"Qatar"];
        self.Doha.hidden = YES;
        return;
    }
    NSArray *outLineCoordinates = [self.qatar qatarOutlineCoordinates];
    int nmbr = (int)[outLineCoordinates count];
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
        self.Doha.hidden = NO;
    [self buttonTitle:self.QTRButton title:@"Region"];

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
        //NSLog(@" mapping Doha now");
        // MKMapRect rect = [self.QTRView visibleMapRect];
        //NSLog(@"mapview rectangle before = %f, %f, %f, %f", rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
    mappingDoha = YES;
    [self.QTRView removeOverlays:self.QTRView.overlays];
    QTRParks *parks = [[QTRParks alloc] init];
    NSArray *parkItems = [parks arrayOfParks];
    for (QTRParkMapItem *itm in parkItems) {
        [self.QTRView addAnnotation:itm];
    }
    [self.QTRView showAnnotations:self.QTRView.annotations animated:YES];
        //rect = [self.QTRView visibleMapRect];
        //NSLog(@"mapview rectangle after = %f, %f, %f, %f", rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);


}




- (void) buttonTitle:(BUTTON *)button title:(NSString *)title
{
#ifdef IS_IOS
    [button setTitle:title forState:UIControlStateNormal];
#endif
#ifdef IS_OSX
    [button setTitle:title];
#endif
}

#pragma mark - delegate methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        {
        return nil;  // this should never trigger
        }
    if ([annotation isKindOfClass:[QTRParkMapItem class]])  // for Japanese Tea Garden
        {
            //static NSString *TeaGardenAnnotationIdentifier = @"TeaGardenAnnotationIdentifier";

        QTRParkAnnotationView *annotationView = [[QTRParkAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:Nil];
            //(QTRParkAnnotationView *)[self.QTRView dequeueReusableAnnotationViewWithIdentifier:TeaGardenAnnotationIdentifier];
            //if (annotationView == nil)
            //{
            //annotationView = [[QTRParkAnnotationView alloc] initWithAnnotation:annotation]; //reuseIdentifier:TeaGardenAnnotationIdentifier];
            // }
        return annotationView;
        }

    return nil;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
        //MKMapRect rect = [self.QTRView visibleMapRect];
        //NSLog(@"mapview rectangle did change = %f, %f, %f, %f", rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
        //rect.size.width +=8000;
        //rect.size.height +=8000;
    if (mappingDoha) {
            //        [self.QTRView  setVisibleMapRect:rect animated:YES]; }
        mappingDoha = NO;
        self.QTRView.camera.altitude *= 1.3;
    }

}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
//    MKMapRect rect = [self.QTRView visibleMapRect];
//    NSLog(@"mapview rectangle will change = %f, %f, %f, %f", rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);

}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if ([overlay isKindOfClass:QTRQatarMapOverlay.class]) {
        IMAGE *QFlag = [IMAGE imageNamed:@"QFlag"];
        QTRQatarMapOverlayView *overlayView = [[QTRQatarMapOverlayView alloc] initWithOverlay:overlay overlayImage:QFlag];
        overlayView.alpha = 0.5;
        return overlayView;
    }
        //IMAGE *pattern = [IMAGE imageNamed:@"QFLag"];
        //COLOR *clr = [COLOR colorWithPatternImage:pattern];

        //COLOR *fillColor = [COLOR colorWithHue:.5 saturation:.5 brightness:.5 alpha:.5];
        //COLOR *fillColor = [[COLOR alloc] initWithPatternImage:[IMAGE imageNamed:@"candy-stripe1.jpg"]];;
    COLOR *strokeColor = [COLOR clearColor];
        //COLOR *strokeColor = [COLOR colorWithRed:0 green:0 blue:0 alpha:0.5f];

    self.polyRender = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
    self.polyRender.strokeColor =strokeColor;
    [self.polyRender setFillColor:[COLOR  colorWithPatternImage:[IMAGE imageNamed:@"paper_stripes.jpg"]]];
    self.polyRender.alpha = 0.6;
    return self.polyRender;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"annotation was selected");
}

@end
