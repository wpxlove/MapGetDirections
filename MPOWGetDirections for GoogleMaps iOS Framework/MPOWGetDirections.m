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
#import "MPOWGetDirections.h"

@implementation MPOWGetDirections

-(void) setSearchModeOption:(MPGetDirectionOption)option{
    searchModeOption=option;
    NSLog(@"option setted: %i",option);
}

-(int) requestDirecionsAndshowOnMap:(GMSMapView *)aMapView{
    

        NSArray* mode=[[NSArray alloc]initWithObjects:@"transit",@"bicycling",@"walking",@"driving", nil];
        NSString *depart=[[NSString alloc] initWithFormat:@""];
        NSString *origin=[[NSString alloc] initWithFormat:@""];
        NSString *destination=[[NSString alloc] initWithFormat:@""];
    
    if (self.setLanguage)
    self.setLanguage=[NSString stringWithFormat:@"language=%@",self.setLanguage];
    else self.setLanguage=@"language=en";

    if (searchModeOption==0) {
        if (self.departDate==nil) {
            self.departDate=[NSDate date];
        }
        
        depart=[NSString stringWithFormat:@"&departure_time=%i",(int)[self.departDate timeIntervalSince1970]];
        
        }
    
    if (self.origin) {
        origin=[NSString stringWithFormat:@"origin=%@",self.origin];
    }else if (self.originCoordinate.latitude && self.originCoordinate.longitude){
        origin=[NSString stringWithFormat:@"origin=%f,%f",self.originCoordinate.latitude,self.originCoordinate.longitude];
    }else{
        NSLog(@"No origin setted");
        return -1;
    }
        
    if (self.destination) {
        destination=[NSString stringWithFormat:@"destination=%@",self.destination];
    }else if (self.destinationCoordinate.latitude && self.destinationCoordinate.longitude){
        destination=[NSString stringWithFormat:@"destination=%f,%f",self.destinationCoordinate.latitude,self.destinationCoordinate.longitude];
    }else{
        NSLog(@"No destination setted");
        return -1;
    }
    
    NSString* URLforRequest=[[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?%@&%@&sensor=false&%@&alternative=false&mode=%@%@",origin,destination,self.setLanguage,[mode objectAtIndex:searchModeOption],depart] stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    
       // NSLog(@"%@",URLforRequest);
    
        NSURLRequest *requests = [NSURLRequest requestWithURL:[NSURL URLWithString:URLforRequest]];
        
        [NSURLConnection sendAsynchronousRequest:requests queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
            
            if (error==nil && data) {
               // NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                directions = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                if (error) {
                    NSLog(@"%@",error);
                }
                NSString* status=[directions objectForKey:@"status"];
                NSLog(@"Status: %@", status);
                
                if ([status isEqualToString:@"OK"]) {
                    [self decodeResult];
                    if (aMapView)
                    [self showOnMap:aMapView];
                }
            }else NSLog(@"%@",error);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Request Done" object:nil];

            
        }];
   

    return 0;
}

-(void) decodeResult{
    
    self.destination=[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"end_address"];

    self.distance=[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"distance"] objectForKey:@"text"] doubleValue];

    self.duration=[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"duration"] objectForKey:@"text"];
    
    //Get Array of Instructions

    self.instrunctions=[[NSMutableArray alloc] init];
    
    for (int n=0; n<[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"steps"]count]; n++) {
        [self.instrunctions addObject:[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"] objectAtIndex:0] objectForKey:@"steps"] objectAtIndex:n] objectForKey:@"html_instructions"]];
    }
    
    //Get Overview Polyline
    
    NSString *polystring=[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"overview_polyline"]  objectForKey:@"points"];
    NSMutableArray* decodedpolystring=[self decodePolyLine:polystring];
    
    int numberOfCC=[decodedpolystring count];
    GMSMutablePath *path = [GMSMutablePath path];

    for (int index = 0; index < numberOfCC; index++) {
        CLLocation *location = [decodedpolystring objectAtIndex:index];
        CLLocationCoordinate2D coordinate = location.coordinate;
        [path addLatitude:coordinate.latitude longitude:coordinate.longitude];
    }
    
   self.overviewPolilyne= [GMSPolyline polylineWithPath:path];

    //Get Coordinates of origin and destination to be displayed on a map
    float lat=[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"]objectAtIndex:0] objectForKey:@"end_location"] objectForKey:@"lat"] floatValue];
    float lng=[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"]objectAtIndex:0] objectForKey:@"end_location"] objectForKey:@"lng"] floatValue];
    CLLocationCoordinate2D tmp;
    tmp.latitude=lat;
    tmp.longitude=lng;
    self.destinationCoordinate=tmp;
   
     lat=[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"]objectAtIndex:0] objectForKey:@"start_location"] objectForKey:@"lat"] floatValue];
     lng=[[[[[[[directions objectForKey:@"routes"] objectAtIndex:0] objectForKey:@"legs"]objectAtIndex:0] objectForKey:@"start_location"] objectForKey:@"lng"] floatValue];
    tmp.latitude=lat;
    tmp.longitude=lng;
    self.originCoordinate=tmp;
 
}



-(NSMutableArray *)decodePolyLine:(NSString *)encodedStr {
    NSMutableString *encoded = [[NSMutableString alloc] initWithCapacity:[encodedStr length]];
    [encoded appendString:encodedStr];
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:location];
    }
    
    return array;
}

-(void)showOnMap:(GMSMapView *)aMapView{
    GMSPolyline *polyline =self.overviewPolilyne;
    polyline.strokeColor = [UIColor blueColor];
    polyline.strokeWidth = 2.f;
    polyline.geodesic = YES;
    polyline.map = aMapView;
    
   
}

@end
