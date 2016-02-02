//
//  BCGClueEditionTableViewController.m
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 08/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGClueEditionTableViewController.h"
#import "BCGClue.h"
#import "BCGCluesManager.h"


@interface BCGClueEditionTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UITextField *clueDescription;

@property (assign, nonatomic, getter = isClueDescriptionFieldValid) BOOL clueDescriptionFieldValid;

@end

@implementation BCGClueEditionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.saveButton.enabled = NO;
    
    self.majorLabel.text = [NSString stringWithFormat:@"%@", self.beacon.major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", self.beacon.minor];
    
    [self.clueDescription addTarget:self action:@selector(clueDescriptionTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)clueDescriptionTextFieldChanged:(UITextField *)textField {
    if (textField.text.length > 0) {
        self.clueDescriptionFieldValid = YES;
    } else {
        self.clueDescriptionFieldValid = NO;
    }
    
    self.saveButton.enabled = self.isClueDescriptionFieldValid;
}

- (IBAction)saveTouchButton:(id)sender
{
    NSLog(@"Saved");
    BCGClue *clue = [[BCGClue alloc] initWithBeacon:self.beacon clueDescription:self.clueDescription.text];
    
    [[BCGCluesManager sharedManager] addNextClue:clue];
    
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:TRUE];
}
- (IBAction)cancelTouchButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
