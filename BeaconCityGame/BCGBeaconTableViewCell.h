//
//  BCGBeaconTableViewCell.h
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 06/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCGBeaconTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *proximityLabel;

@end
