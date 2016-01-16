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
    NSLog(@"hour: %d", hour);
    
    NSInteger minutes = [[dateFormatterMinutes stringFromDate:self.delayTimePicker.date] integerValue];
    NSLog(@"minutes: %d", minutes);
    
    NSInteger seconds = hour*60*60 + minutes*60;
    
    [[BCGCluesManager sharedManager] setGameDelayTime:seconds];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pickerAction:(id)sender
{

//    [[BCGCluesManager sharedManager] setGameDelayTime:[[dateFormatter stringFromDate:self.delayTimePicker.date] integerValue]];
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
