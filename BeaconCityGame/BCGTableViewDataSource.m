//
//  BCGTableViewDataSource.m
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 07/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGTableViewDataSource.h"
#import "BCGBeaconTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <ESTBeaconManager.h>

@interface BCGTableViewDataSource () <ESTBeaconManagerDelegate>

@property (strong, nonatomic) CLBeacon *beacon;
@property (strong, nonatomic) ESTBeaconManager *beaconManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSArray<CLBeacon *> *beacons;

@end

@implementation BCGTableViewDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
        
        self.beacons = [NSArray new];
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
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"You've done it!";
    notification.soundName = @"Default.mp3";
    NSLog(@"You've entered");
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)beaconManager:(id)manager didExitRegion:(CLBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"You've exited!";
    notification.soundName = @"Default.mp3";
    NSLog(@"You've exited");
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region
{
    if (beacons.count > 0) {
        self.beacons = beacons;
        [self.delegate reloadTableView];
    }
}

- (NSString *)textForProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityFar:
            return @"Far";
        case CLProximityImmediate:
            return @"Immediate";
        case CLProximityNear:
            return @"Near";
        case CLProximityUnknown:
            return @"Unknown";
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.beacons ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.beacons ? self.beacons.count : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BCGBeaconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCGBeaconTableViewCell"];
    
    CLBeacon *beacon = [self.beacons objectAtIndex:indexPath.row];
    
    cell.proximityLabel.text = [self textForProximity:beacon.proximity];
    cell.majorLabel.text = [NSString stringWithFormat:@"%@", beacon.major];
    cell.minorLabel.text = [NSString stringWithFormat:@"%@", beacon.minor];
    
    return cell;
}


@end
