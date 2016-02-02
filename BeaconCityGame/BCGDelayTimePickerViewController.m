//
//  BCGDelayTimePickerViewController.m
//  BeaconCityGame
//
//  Created by Bartosz on 16/01/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGDelayTimePickerViewController.h"
#import "BCGCluesManager.h"

@interface BCGDelayTimePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *delayTimePicker;

@end

@implementation BCGDelayTimePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.delayTimePicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    self.delayTimePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    self.delayTimePicker.countDownDuration = 30;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BlurredCityLights"]];
}
- (IBAction)doneTouchButton:(id)sender
{
    NSDateFormatter *dateFormatterMinutes = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatterHour = [[NSDateFormatter alloc] init];
    
    [dateFormatterMinutes setDateFormat:@"mm"];
    [dateFormatterHour setDateFormat:@"HH"];
    
    NSInteger hour = [[dateFormatterHour stringFromDate:self.delayTimePicker.date] integerValue];
    NSLog(@"hour: %ld", (long)hour);
    
    NSInteger minutes = [[dateFormatterMinutes stringFromDate:self.delayTimePicker.date] integerValue];
    NSLog(@"minutes: %ld", (long)minutes);
    
    NSInteger seconds = hour*60*60 + minutes*60;
    
    [[BCGCluesManager sharedManager] setGameDelayTime:seconds];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
