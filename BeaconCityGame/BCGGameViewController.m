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
#import "BCGiCarouselViewController.h"

static NSString *const kDidRangeBeacons = @"kDidRangeBeacons";
static NSString *const kFoundNextClue = @"kFoundNextClue";

@interface BCGGameViewController ()

@property (weak, nonatomic) IBOutlet UIView *carouselContainer;
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
    
    
    self.beaconInformationLabel.text = [NSString stringWithFormat:@"Looking for clues."];
    self.carouselContainer.hidden = YES;
    
}

-(void)unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDidRangeBeacons object:nil];
}

-(void)viewDidUnload
{
    [self unregisterForNotifications];
}

- (void)didRangeBeacons:(NSNotification *)notification
{
    self.beacons = [notification.userInfo objectForKey:@"Beacons"];
    BCGClue *clueToFind;
    
    if (self.nrOfClueToFind < [[BCGCluesManager sharedManager] numberOfClues]) {
        clueToFind = [[BCGCluesManager sharedManager] clueAtIndex:self.nrOfClueToFind];
    }
    
    for (CLBeacon *beacon in self.beacons) {
        if ( [beacon.major isEqual: clueToFind.beacon.major] && [beacon.minor isEqual:clueToFind.beacon.minor] && beacon.proximity != CLProximityNear && beacon.proximity != CLProximityImmediate) {
            self.beaconInformationLabel.text = [NSString stringWithFormat:@"You are close to find clue with nr: %ld", (long)self.nrOfClueToFind + 1];
        } else if ( [beacon.major isEqual: clueToFind.beacon.major] && [beacon.minor isEqual:clueToFind.beacon.minor] && (beacon.proximity == CLProximityNear || beacon.proximity == CLProximityImmediate)) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Found Clue"
                                                                           message:[NSString stringWithFormat:@"Found clue with nr: %ld and description: %@", (long)self.nrOfClueToFind + 1, clueToFind.clueDescription]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            
            [self presentViewController:alert animated:YES completion:^{
                NSDictionary *dict = @{@"Clue": clueToFind};
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kFoundNextClue
                                                                    object:NULL
                                                                  userInfo:dict];
                if (self.carouselContainer.isHidden) {
                    [UIView animateWithDuration:0.5 animations:^{
                        self.carouselContainer.hidden = NO;
                    }];
                }
                self.nrOfClueToFind = self.nrOfClueToFind + 1;
                if (![self.foundClues containsObject:clueToFind]) {
                    [self.foundClues addObject: clueToFind];
                }
            }];
        } else {
            self.beaconInformationLabel.text = [NSString stringWithFormat:@"Found %d. Look for clues", self.nrOfClueToFind];
        }
    }
    
    [self.radar startAnimation];
    
    if ([self.foundClues count] == [[BCGCluesManager sharedManager] numberOfClues]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Finished!"
                                                                       message:[NSString stringWithFormat:@"Congratulations! You've found all clues!"]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [self.navigationController popToRootViewControllerAnimated:YES];
                                                              }];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:^{
            [[BCGCluesManager sharedManager] resetClues];
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
