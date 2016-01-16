//
//  BCGBeaconRadiostation.m
//  BeaconCityGame
//
//  Created by Bartosz on 02/01/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGBeaconRadiostation.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

static NSString *const kDidRangeBeacons = @"kDidRangeBeacons";
static NSString *const kDidExitBeacon = @"kDidExitBeacon";

@interface BCGBeaconRadiostation() <ESTBeaconManagerDelegate>

@property (strong, nonatomic) CLBeacon *beacon;
@property (strong, nonatomic) ESTBeaconManager *beaconManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;

@end

@implementation BCGBeaconRadiostation

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
        
        self.beaconManager = [ESTBeaconManager new];
        self.beaconManager.delegate = self;
        
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                               identifier:@"MyIdentifier"];
        self.beaconRegion.notifyOnEntry = YES;
        self.beaconRegion.notifyOnExit = YES;
        
        [self.beaconManager startMonitoringForRegion:self.beaconRegion];
        
        [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
        
        [self.beaconManager requestAlwaysAuthorization];
    }
    return self;
}

- (void)beaconManager:(id)manager monitoringDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"Region Did Fail: Manager:%@ Region: %@ Error:%@", manager, region, error);
}

- (void)beaconManager:(id)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"status:%d", status);
}

-(void)beaconManager:(id)manager didEnterRegion:(CLBeaconRegion *)region
{
    NSLog(@"You've entered");
}

- (void)beaconManager:(id)manager didExitRegion:(CLBeaconRegion *)region
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidExitBeacon
                                                        object:NULL
                                                      userInfo:NULL];
    NSLog(@"You've exited");
}

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region
{
    NSDictionary *dict = @{@"Beacons": beacons};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidRangeBeacons
                                                        object:NULL
                                                      userInfo:dict];
}

@end
