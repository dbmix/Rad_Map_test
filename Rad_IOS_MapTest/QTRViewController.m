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
#import "QTRStripesMapOverlay.h"
#import "QTRStripesOverlayView.h"

@interface QTRViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *QTRView;
@property (strong, nonatomic) BUTTON *QTRButton;
@property (strong, nonatomic) MKPolygon *demoPolygon;
@property (strong, nonatomic) MKPolygonRenderer *polyRender;
@property (strong, nonatomic) Qatar *qatar;
@property (strong, nonatomic) BUTTON *QTRFlag;
@property (strong, nonatomic) QTRStripesMapOverlay *flagOverlay;  //change this to QTRQatarMapOverlay for flag image
@property (strong, nonatomic) BUTTON *Doha;
@property (strong, nonatomic) NSDictionary *viewsDictionary;

@end

@implementation QTRViewController



    // Main action for the app




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

        [self.Doha setTitle:@"Doha Parks"];
        [self.Doha setAction:@selector(mapDoha)];
        [self addButtonsAndConstraints];


        
        
    }
    return self;
}
#endif  // end of OS X initiator

#ifdef IS_IOS

    //iPhone view life cycle


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
    [self.Doha setTitle:@"Doha Parks" forState:UIControlStateNormal];
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

    /*
        // testing testing
        // start with our position and derive a nice unit for drawing

    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(25.304, 51.26);
    CGFloat lat = loc.latitude;
    CLLocationDistance metersPerPoint = MKMetersPerMapPointAtLatitude(lat);
    MKMapPoint c = MKMapPointForCoordinate(loc);
    CGFloat unit = 11000.0/metersPerPoint;
        // size and position the overlay bounds on the earth
    CGSize sz = CGSizeMake(4*unit, 4*unit);
    MKMapRect mr = MKMapRectMake(c.x + 2*unit, c.y - 4.5*unit, sz.width, sz.height);
        // describe the arrow as a CGPath
    CGMutablePathRef p = CGPathCreateMutable();
    CGPoint start = CGPointMake(0, unit*1.5);
    CGPoint p1 = CGPointMake(start.x+2*unit, start.y);
    CGPoint p2 = CGPointMake(p1.x, p1.y-unit);
    CGPoint p3 = CGPointMake(p2.x+unit*2, p2.y+unit*1.5);
    CGPoint p4 = CGPointMake(p2.x, p2.y+unit*3);
    CGPoint p5 = CGPointMake(p4.x, p4.y-unit);
    CGPoint p6 = CGPointMake(p5.x-2*unit, p5.y);
    CGPoint points[] = {
        start, p1, p2, p3, p4, p5, p6
    };
        // rotate the arrow around its center
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(unit*2, unit*2);
    CGAffineTransform t2 = CGAffineTransformRotate(t1, -M_PI/3.5);
    CGAffineTransform t3 = CGAffineTransformTranslate(t2, -unit*2, -unit*2);
    CGPathAddLines(p, &t3, points, 7);
    CGPathCloseSubpath(p);

        // create the overlay and give it the path
        //MyOverlay* over = [[MyOverlay alloc] initWithRect:mr];
    self.qatar.path = [UIBezierPath bezierPathWithCGPath:p];
    CGPathRelease(p);

        // end of testing testing */

    [self.QTRView addOverlay:self.demoPolygon level:MKOverlayLevelAboveRoads]; // play with the insertion level
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
        //self.flagOverlay = [[QTRQatarMapOverlay alloc] initWithRegion:self.qatar]; //use this for flag version
    self.flagOverlay = [[QTRStripesMapOverlay alloc] initWithRegion:self.qatar];   // turn this off for flag version
    [self.QTRView addOverlay:self.flagOverlay level:MKOverlayLevelAboveRoads]; // can also insert above Labels
    graphicOverlay = YES;
}

- (void) mapDoha {
    mappingDoha = YES;
    [self.QTRView removeOverlays:self.QTRView.overlays];
    QTRParks *parks = [[QTRParks alloc] init];
    NSArray *parkItems = [parks arrayOfParks];
    for (QTRParkMapItem *itm in parkItems) {
        [self.QTRView addAnnotation:itm];
    }
    [self.QTRView showAnnotations:self.QTRView.annotations animated:YES];

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
    if ([annotation isKindOfClass:[QTRParkMapItem class]])
        {

        QTRParkAnnotationView *annotationView = [[QTRParkAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:Nil];

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
    } else if ([overlay isKindOfClass:QTRStripesMapOverlay.class]) {   ////change this to QTRQatarMapOverlay for flag image
        QTRStripesOverlayView *overlayView = [[QTRStripesOverlayView alloc] initWithOverlay:overlay];
        return overlayView;
    }
    COLOR *strokeColor = [COLOR clearColor];

    self.polyRender = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
    self.polyRender.strokeColor = strokeColor;

    COLOR *color = [[COLOR alloc] initWithPatternImage:[IMAGE imageNamed:@"paper_stripes.jpg"]];
        //[color set];
    self.polyRender.fillColor = color;
    self.polyRender.alpha = 0.6;
    return self.polyRender;

   /* MKOverlayPathRenderer *v = nil;
    v = [[MKOverlayPathRenderer alloc] initWithOverlay:overlay];
    MKOverlayPathRenderer* vv = (MKOverlayPathRenderer*)v;

    CGContextRef con = UIGraphicsGetCurrentContext();
        //CGContextSaveGState(con);
    UIGraphicsPushContext(con);

    CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(nil);
    CGContextSetFillColorSpace (con, sp2);
    CGColorSpaceRelease (sp2);
    CGPatternCallbacks callback = {0, drawStripes, nil};
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGPatternRef patt = CGPatternCreate(nil,
                                        CGRectMake(0,0,4,4),
                                        tr,
                                        4, 4,
                                        kCGPatternTilingConstantSpacingMinimalDistortion,
                                        true,
                                        &callback);
    CGFloat alph = 1.0;
    CGContextSetFillPattern(con, patt, &alph);
    CGPatternRelease(patt);
    
    

    vv.path = self.qatar.path.CGPath;
    vv.strokeColor = [UIColor blackColor];
        //vv.fillColor = color; //[[UIColor redColor] colorWithAlphaComponent:0.2];
    vv.lineWidth = 2;
        //[vv applyFillPropertiesToContext:graphics_context atZoomScale:1.0];
    return vv; */

}



- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"annotation was selected");
}

@end
