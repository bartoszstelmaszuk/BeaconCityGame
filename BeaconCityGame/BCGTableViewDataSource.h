//
//  BCGTableViewDataSource.h
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 07/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ESTBeaconManager.h>

@protocol BCGTableViewDataSourceDelegate

- (void)reloadTableView;

@end

@interface BCGTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) id<BCGTableViewDataSourceDelegate> delegate;

- (CLBeacon *)getBeaconAtIndexPath:(NSIndexPath *) indexPath;

@end
