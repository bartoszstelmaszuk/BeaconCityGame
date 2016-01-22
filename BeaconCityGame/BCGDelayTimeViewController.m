//
//  BCGDelayTimeViewController.m
//  BeaconCityGame
//
//  Created by Bartosz on 22/01/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGDelayTimeViewController.h"
#import <JWGCircleCounter/JWGCircleCounter.h>

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
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.circleCounter startWithSeconds:8];
}

- (void)circleCounterTimeDidExpire:(JWGCircleCounter *)circleCounter {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Timer Expired"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
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
