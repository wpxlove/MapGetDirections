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

#import "MPOWAppDelegate.h"

@implementation MPOWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#warning replace with your API key
    [GMSServices provideAPIKey:@"REPLACE_WITH_YOUR_KEY"];
    //replace with your API Key https://code.google.com/apis/console/
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
