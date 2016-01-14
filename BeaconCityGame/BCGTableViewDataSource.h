//
//  BCGTableViewDataSource.h
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 07/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EstimoteSDK/ESTBeaconManager.h>

@protocol BCGTableViewDataSourceDelegate

- (void)reloadTableView;

@end

@interface BCGTableViewDataSource : NSObject <UITableViewDataSource, ESTBeaconManagerDelegate>

@property (nonatomic, strong) id<BCGTableViewDataSourceDelegate> delegate;
@property (strong, nonatomic) NSArray<CLBeacon *> *beacons;

- (CLBeacon *)getBeaconAtIndexPath:(NSIndexPath *) indexPath;
- (void)didRangeBeacons:(NSNotification *)notification;

@end
