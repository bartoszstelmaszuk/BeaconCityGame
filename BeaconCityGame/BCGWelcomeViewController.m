//
//  BCGWelcomeViewController.m
//  BeaconCityGame
//
//  Created by Bartosz on 11/01/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGWelcomeViewController.h"
#import <CCMRadarView/CCMRadarView-Swift.h>

static NSString *const kDidRangeBeacons = @"kDidRangeBeacons";

@interface BCGWelcomeViewController ()

@property (weak, nonatomic) IBOutlet CCMRadarView *radar;
@property (weak, nonatomic) IBOutlet UILabel *beaconInformationLabel;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
@property (strong, nonatomic) NSArray *beacons;

@end

@implementation BCGWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRangeBeacons:)
                                                 name:kDidRangeBeacons
                                               object:NULL];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didExitBeacon:)
//                                                 name:kDidExitBeacon
//                                               object:NULL];
    
    self.beaconInformationLabel.text = [NSString stringWithFormat:@"No iBeacons around. Please collect them near phone"];
}

//- (void)didExitBeacon:(NSNotification *)notification
//{
//    self.beaconsNumber = self.beaconsNumber - 1;
//    if (self.beaconsNumber == 0) {
//        self.beaconInformationLabel.text = [NSString stringWithFormat:@"No iBeacons around. Please collect them near phone"];
//    }
//}

- (void)didRangeBeacons:(NSNotification *)notification
{
    self.beacons = [notification.userInfo objectForKey:@"Beacons"];
    if (self.beacons.count > 0) {
        self.beaconInformationLabel.text = [NSString stringWithFormat:@"Found %lu iBeacons. Do you want to start a game?", (unsigned long)self.beacons.count];
    } else {
        self.beaconInformationLabel.text = [NSString stringWithFormat:@"No iBeacons around. Please collect them near phone"];
    }
}
- (IBAction)startGameTouchButton:(id)sender {
    
    if (self.beacons.count > 0) {
        [self performSegueWithIdentifier:@"ShowBeacons" sender:NULL];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"You don't have enough iBeacons to create a game!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.radar startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
