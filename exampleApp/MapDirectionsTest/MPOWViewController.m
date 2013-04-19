//
//  MPOWGetDirections by MPOW
//
//  Twitter @manzopower
//  Mail manzopower@icloud.com
//
// READ the GoogleMapsAPI TERMS BEFORE USE https://developers.google.com/maps/terms
//
// You MUST use the Google Maps Framework to use that
// To use MapKit see the other version and read his limits
//
//
//  Created by MPow on 19/04/13.
//  Copyright (c) 2013 MPow. All rights reserved.
//
// I'm not responsible of the use, if you do not respect the GoggleMaps API Terms

#import "MPOWViewController.h"

@interface MPOWViewController ()

@end

@implementation MPOWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:44.3715
                                                            longitude:9.1086
                                                                 zoom:13];
    
    mainMap=[[GMSMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    mainMap.camera=camera;
    mainMap.myLocationEnabled=YES;
    [self.view addSubview:mainMap];
    
    getDirections=[[MPOWGetDirections alloc] init];
    [getDirections setSearchModeOption:MPGetDirectionDriving];
    
    //Set origin and destination using name
    getDirections.origin=@"Via Crispi Sori";
    getDirections.destination=@"Genova";
    
    // you can also use coordinates to set origin or destination
    // getDirections.originCoordinate
    // getDirections.destinationCoordinate
    // they are CLLocationCoordinate2D
    
    getDirections.setLanguage=@"it"; //use code for language default is : en
    
    [getDirections requestDirecionsAndshowOnMap:mainMap];
    
    // That if you want to know when the request is finished because I'm using AsynchronousRequest to not slow your App
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"Request Done"
                                               object:nil]; 

    
	
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) receiveTestNotification:(NSNotification *) notification
{
    // and these are all the info you get
    NSString *destination=getDirections.destination;
    NSString *origin=getDirections.origin;
    CLLocationCoordinate2D originCoordinate=getDirections.originCoordinate;
    CLLocationCoordinate2D destinationCoordinate=getDirections.destinationCoordinate;
  //  NSDate* departDate=getDirections.departDate; // you must set if you use MPGetDirectionTransport
    NSString *duration=getDirections.duration;
    double distance=getDirections.distance;
    NSMutableArray* instrunctions=getDirections.instrunctions;
   // GMSPolyline* overviewPolilyne=getDirections.overviewPolilyne;

    NSLog(@"Origin %@ %f %f, Destination %@ %f %f, duration %@, distance %f ecc....",origin , originCoordinate.latitude, originCoordinate.longitude, destination,destinationCoordinate.latitude, destinationCoordinate.longitude, duration, distance);
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"Example First Instruction" message:[instrunctions objectAtIndex:0] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil]; // note that the instructions are in HTML
    [alert show];}
@end

