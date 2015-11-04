//
//  ViewController.m
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 02/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <ESTBeaconManager.h>

@interface ViewController () <ESTBeaconManagerDelegate>

@property (strong, nonatomic) CLBeacon *beacon;
@property (strong, nonatomic) ESTBeaconManager *beaconManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (weak, nonatomic) IBOutlet UILabel *beaconProximityLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:43355
                                                                minor:9819
                                                           identifier:@"MyIdentifier"];
    
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
    
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    
    [self.beaconManager requestAlwaysAuthorization];
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
        CLBeacon *firstBeacon = [beacons firstObject];
        self.beaconProximityLabel.text = [self textForProximity:firstBeacon.proximity];
    }
}

- (NSString *)textForProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityFar:
            NSLog(@"Far");
            return @"Far";
        case CLProximityImmediate:
            NSLog(@"Immediate");
            self.beaconProximityLabel.textColor = [UIColor purpleColor];
            return @"Immediate";
        case CLProximityNear:
            NSLog(@"Near");
            self.beaconProximityLabel.textColor = [UIColor greenColor];
            return @"Near";
        case CLProximityUnknown:
            NSLog(@"Unknown");
            return @"Unknown";
            
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
