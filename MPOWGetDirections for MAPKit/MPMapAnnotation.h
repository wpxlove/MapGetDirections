//
//  MPOWGetDirections by MPOW
//
//  Twitter @manzopower
//  Mail manzopower@icloud.com
//
// READ the GoogleMapsAPI TERMS BEFORE USE https://developers.google.com/maps/terms
//
//
//  Created by MPow on 19/04/13.
//  Copyright (c) 2013 MPow. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
@interface MPMapAnnotation : NSObject<MKAnnotation>{
	CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}
-(void) setTitle:(NSString *)titletoset;
-(void) setSubtitle:(NSString *)titletoset;
-(void) setCoorWithLong:(float)lng andLat:(float)lat;
@end
