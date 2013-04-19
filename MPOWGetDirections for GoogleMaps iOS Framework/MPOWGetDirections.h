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

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
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
@property(nonatomic,strong) GMSPolyline* overviewPolilyne;


-(void) setSearchModeOption:(MPGetDirectionOption)option;
-(int) requestDirecionsAndshowOnMap:(GMSMapView *)aMapView;
-(void) decodeResult;

@end
