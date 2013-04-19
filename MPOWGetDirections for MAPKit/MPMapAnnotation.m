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


#import "MPMapAnnotation.h"

@implementation MPMapAnnotation
@synthesize coordinate,subtitle,title;


-(void) setTitle:(NSString *)titletoset{
    title=titletoset;
}
-(void) setSubtitle:(NSString *)titletoset{
    subtitle=titletoset;
}
-(void) setCoorWithLong:(float)lng andLat:(float)lat{
    coordinate.latitude=lat;
    coordinate.longitude=lng;
}


- (NSString *)title {
	return title;
}


- (NSString *)subtitle {
	return subtitle;
}




@end
