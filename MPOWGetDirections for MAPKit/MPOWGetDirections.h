//
//  MPOWGetDirections by MPOW
//
//  Twitter @manzopower
//  Mail manzopower@icloud.com
//
// READ the GoogleMapsAPI TERMS BEFORE USE https://developers.google.com/maps/terms
//
// This is only for use with MApKit framework BUT
// Use Google Maps direction with iOS 6 MapKit is not Permitted by Google Terms
// so use it only on previous version of iOS that use Google Map 
//
// if you want to use in iOS 6 use the version that use the Google Maps framework
//
//
// THAT'S THE TERM THAT DO NOT PERMIT THE YUSE WITH APPLE's MAPS
//
// the Directions API may only be used in conjunction with displaying results on a Google map;
// using Directions data without displaying a map for which directions data was requested is prohibited.
// Additionally, calculation of directions generates copyrights and warnings which must be displayed to the user in some fashion.
// For complete details on allowed usage
//
//
//
//  Created by MPow on 19/04/13.
//  Copyright (c) 2013 MPow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MPMapAnnotation.h"

typedef NS_ENUM(NSInteger, MPGetDirectionOption)
{
    MPGetDirectionTransport = 0,
    MPGetDirectionBicycling,
    MPGetDirectionWalking,
    MPGetDirectionDriving,
};

@interface MPOWGetDirections : NSObject{
    
    int searchModeOption;
    NSMutableDictionary* directions;

}

@property(nonatomic,strong) NSString *destination;
@property(nonatomic,strong) NSString *origin;
@property(nonatomic,strong) NSString *setLanguage;
@property(nonatomic,readwrite) CLLocationCoordinate2D originCoordinate;
@property(nonatomic,readwrite) CLLocationCoordinate2D destinationCoordinate;
@property(nonatomic) NSDate* departDate;
@property(nonatomic,strong) NSString *duration;
@property(nonatomic) double distance;
@property(nonatomic,strong) NSMutableArray* instrunctions;
@property(nonatomic,strong) NSMutableArray* polylines;
@property(nonatomic,strong) MKPolyline* overviewPolilyne;


-(void) setSearchModeOption:(MPGetDirectionOption)option;
-(int) requestDirecionsAndshowOnMap:(MKMapView *)aMapView;
-(void) decodeResult;

@end
