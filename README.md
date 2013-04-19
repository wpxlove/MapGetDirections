Class to get directions with google Maps APIs
Really easy to use 

``` Obj-C

MPOWGetDirections* getDirections=[[MPOWGetDirections alloc] init];
    [getDirections setSearchModeOption:MPGetDirectionWalking];
    
    //Set origin and destination using name
    getDirections.origin=@"Genoa";
    getDirections.destination=@"Milan";
    
    // you can also use coordinates to set origin or destination
    // getDirections.originCoordinate
    // getDirections.destinationCoordinate
    // they are CLLocationCoordinate2D
    
    getDirections.setLanguage=@"it"; //use code for language default is : en

	[getDirections requestDirecionsAndshowOnMap:yourMap];
	
	//If you want to know when the request is finished 
	  [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"Request Done"
                                               object:nil]; // That if you want to know when the request is finished because I'm using AsynchronousRequest to not slow your App


	// and these are all the info you get after the request is finished
    NSString *destination=getDirections.destination;
    NSString *origin=getDirections.origin;
    CLLocationCoordinate2D originCoordinate=getDirections.originCoordinate;
    CLLocationCoordinate2D destinationCoordinate=getDirections.destinationCoordinate;
    NSDate* departDate=getDirections.departDate; // you must set if you use MPGetDirectionTransport
    NSString *duration=getDirections.duration;
    double distance=getDirections.distance;
    NSMutableArray* instrunctions=getDirections.instrunctions;
    GMSPolyline* overviewPolilyne=getDirections.overviewPolilyne;

```

 There are 2 difference version of the Class
 one for use with Google Maps frameworks for iOS
 one for Mapkit BUT 

READ the GoogleMapsAPI TERMS BEFORE USE https:developers.google.com/maps/terms

 The Use of Google Maps direction with iOS 6 MapKit is not Permitted by Google Terms
 so use it only on previous version of iOS that use Google Map 

 if you want to use in iOS 6 use the version that use the GoogleMaps iOS framework


 THAT'S THE TERM THAT DO NOT PERMIT THE USE WITH APPLE's MAPS

 the Directions API may only be used in conjunction with displaying results on a Google map;
 using Directions data without displaying a map for which directions data was requested is prohibited.
 Additionally, calculation of directions generates copyrights and warnings which must be displayed to the user in some fashion.
 For complete details on allowed usage


  MPOWGetDirections by MPOW

  Twitter @manzopower
  Mail manzopower@icloud.com


  Created by MPow on 19/04/13.
  Copyright (c) 2013 MPow. All rights reserved.

 I'm not responsible of the use, if you want to use it with Apple's Map 
 and if you do not respect the GoggleMaps API Terms


Code under MIT License and use respecting GoogleMApsAPI Terms
