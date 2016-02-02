//
//  BCGDelayTimeViewController.m
//  BeaconCityGame
//
//  Created by Bartosz on 22/01/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGDelayTimeViewController.h"
#import <JWGCircleCounter/JWGCircleCounter.h>
#import "BCGCluesManager.h"

@interface BCGDelayTimeViewController () <JWGCircleCounterDelegate>

@property (weak, nonatomic) IBOutlet JWGCircleCounter *circleCounter;
@property (weak, nonatomic) IBOutlet UIImageView *delayTimeView;

@end

@implementation BCGDelayTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.delayTimeView.image = [UIImage imageNamed:@"CityLights"];
    self.circleCounter.delegate = self;
    self.circleCounter.backgroundColor = [UIColor clearColor];
    self.circleCounter.circleColor = [UIColor blueColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.circleCounter startWithSeconds:[[BCGCluesManager sharedManager] getDelayTime]];
}

- (void)circleCounterTimeDidExpire:(JWGCircleCounter *)circleCounter {
    
    [self performSegueWithIdentifier:@"ShowGame" sender:nil];
}

@end
