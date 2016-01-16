//
//  BCGTableViewDataSource.m
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 07/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGTableViewDataSource.h"
#import "BCGBeaconTableViewCell.h"
#import "BCGClueTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BCGCluesManager.h"

static const NSString *kDidRangeBeacons = @"kDidRangeBeacons";

@implementation BCGTableViewDataSource

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
    return self.beacons ? 2 : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Beacons";
    } else {
        return @"Clues";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.beacons ? self.beacons.count : 0;
    } else {
        return [BCGCluesManager sharedManager]  ? [[BCGCluesManager sharedManager] numberOfClues] : 0;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            BCGBeaconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCGBeaconTableViewCell"];
            
            CLBeacon *beacon = [self.beacons objectAtIndex:indexPath.row];
            
            cell.proximityLabel.text = [self textForProximity:beacon.proximity];
            cell.majorLabel.text = [NSString stringWithFormat:@"%@", beacon.major];
            cell.minorLabel.text = [NSString stringWithFormat:@"%@", beacon.minor];
            
            return cell;
        }
        case 1:
        {
            BCGClueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCGClueTableViewCell"];
            cell.showsReorderControl = YES;
            
            BCGClue *clue = [[BCGCluesManager sharedManager] clueAtIndex:indexPath.row];
            
            cell.majorLabel.text = [NSString stringWithFormat:@"%@", clue.beacon.major];
            cell.minorLabel.text = [NSString stringWithFormat:@"%@", clue.beacon.minor];
            cell.clueDescriptionLabel.text = clue.clueDescription;
            cell.ClueNumber.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
            return cell;
        }
        default:
            return nil;
    }
}

//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
//{
//    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
//        return proposedDestinationIndexPath;
//    }
//    return sourceIndexPath;
//    return proposedDestinationIndexPath;
//}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    BCGClue *clue = [[BCGCluesManager sharedManager] clueAtIndex:fromIndexPath.row];
    [[BCGCluesManager sharedManager] removeObjectAtIndex:fromIndexPath.row];
    [[BCGCluesManager sharedManager] insertObject:clue atIndex:toIndexPath.row];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return NO;
    }
    
    return YES;
}

- (CLBeacon *)getBeaconAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.beacons objectAtIndex:indexPath.row];
}

@end
