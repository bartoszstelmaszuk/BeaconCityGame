//
//  BCGTableViewController.m
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 06/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGTableViewController.h"
#import "BCGBeaconTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <ESTBeaconManager.h>

@interface BCGTableViewController () <ESTBeaconManagerDelegate>

@property (strong, nonatomic) CLBeacon *beacon;
@property (strong, nonatomic) ESTBeaconManager *beaconManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSArray<CLBeacon *> *beacons;

@end

@implementation BCGTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.beacons = [NSArray new];
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
        self.beacons = beacons;
        [self.tableView reloadData];
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
            return @"Immediate";
        case CLProximityNear:
            NSLog(@"Near");
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
    [self.tableView registerNib:[UINib nibWithNibName:@"BCGBeaconTableViewCell" bundle:nil] forCellReuseIdentifier:@"BCGBeaconTableViewCell"];
    BCGBeaconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BCGBeaconTableViewCell"];

    CLBeacon *beacon = [self.beacons firstObject];
    
    cell.proximityLabel.text = [self textForProximity:beacon.proximity];
    cell.majorLabel.text = [NSString stringWithFormat:@"%@", beacon.major ];
    cell.minorLabel.text = [NSString stringWithFormat:@"%@", beacon.minor];
    cell.uuidLabel.text = beacon.proximityUUID.UUIDString;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
