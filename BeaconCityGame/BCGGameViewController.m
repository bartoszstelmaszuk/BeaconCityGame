//
//  BCGGameViewController.m
//  BeaconCityGame
//
//  Created by Bartosz on 23/01/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGGameViewController.h"
#import <CCMRadarView/CCMRadarView-Swift.h>
#import "BCGClue.h"
#import "BCGCluesManager.h"

static NSString *const kDidRangeBeacons = @"kDidRangeBeacons";

@interface BCGGameViewController ()

@property (weak, nonatomic) IBOutlet CCMRadarView *radar;
@property (weak, nonatomic) IBOutlet UILabel *beaconInformationLabel;
@property (strong, nonatomic) NSArray *beacons;
@property (strong, nonatomic) NSMutableArray *foundClues;
@property (nonatomic) NSInteger nrOfClueToFind;

@end

@implementation BCGGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nrOfClueToFind = 0;
    self.foundClues = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRangeBeacons:)
                                                 name:kDidRangeBeacons
                                               object:NULL];
    
    
    self.beaconInformationLabel.text = [NSString stringWithFormat:@"No iBeacons around. Please collect them near phone"];
}

- (void)didRangeBeacons:(NSNotification *)notification
{
    self.beacons = [notification.userInfo objectForKey:@"Beacons"];
    BCGClue *clueToFind;
    
    if (self.nrOfClueToFind < [[BCGCluesManager sharedManager] numberOfClues]) {
        clueToFind = [[BCGCluesManager sharedManager] clueAtIndex:self.nrOfClueToFind];
    }
    
    for (CLBeacon *beacon in self.beacons) {
        if ( [beacon.major isEqual: clueToFind.beacon.major] && [beacon.minor isEqual:clueToFind.beacon.minor] && beacon.proximity != CLProximityNear) {
            self.beaconInformationLabel.text = [NSString stringWithFormat:@"You are close to find clue with nr: %ld", (long)self.nrOfClueToFind + 1];
        } else if ( [beacon.major isEqual: clueToFind.beacon.major] && [beacon.minor isEqual:clueToFind.beacon.minor] && beacon.proximity == CLProximityNear) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Found Clue"
                                                                           message:[NSString stringWithFormat:@"Found clue with nr: %ld and description: %@", (long)self.nrOfClueToFind + 1, clueToFind.clueDescription]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:^{
                self.nrOfClueToFind = self.nrOfClueToFind + 1;
                if (![self.foundClues containsObject:clueToFind]) {
                    [self.foundClues addObject: clueToFind];
                }
            }];
        } else {
            self.beaconInformationLabel.text = [NSString stringWithFormat:@"Found %d. Look For Clues", self.nrOfClueToFind];
        }
    }
    
    if (self.nrOfClueToFind + 1 == [[BCGCluesManager sharedManager] numberOfClues]) {
        //TODO: end game
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.radar startAnimation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
