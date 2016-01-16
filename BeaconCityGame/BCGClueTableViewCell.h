//
//  BCGClueTableViewCell.h
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 09/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCGClueTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *clueDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ClueNumber;

@end
