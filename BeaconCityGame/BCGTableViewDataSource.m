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
#import "BCGCluesManager.h"

static const NSString *kDidRangeBeacons = @"kDidRangeBeacons";

@interface BCGTableViewDataSource () <ESTBeaconManagerDelegate>

@property (strong, nonatomic) NSArray<CLBeacon *> *beacons;

@end

@implementation BCGTableViewDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didRangeBeacons:)
                                                     name:kDidRangeBeacons
                                                   object:NULL];
    }
    return self;
}

- (void)didRangeBeacons:(NSNotification *)notification
{
    NSArray *beacons = [notification.userInfo objectForKey:@"Beacons"];
    NSMutableArray *temp = [NSMutableArray array];
    if (beacons.count > 0) {
        for (CLBeacon *beacon in beacons) {
            if (![[BCGCluesManager sharedManager] containsBeacon:beacon]) {
                [temp addObject:beacon];
            }
        }
        self.beacons = temp;
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

- (CLBeacon *)getBeaconAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.beacons objectAtIndex:indexPath.row];
}

@end
