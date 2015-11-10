//
//  BCGClueEditionTableViewController.h
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 08/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ESTBeaconManager.h>

@interface BCGClueEditionTableViewController : UITableViewController

@property (nonatomic, strong) CLBeacon *beacon;

@end
