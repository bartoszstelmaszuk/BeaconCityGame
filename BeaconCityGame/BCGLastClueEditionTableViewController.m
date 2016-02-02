//
//  BCGLastClueEditionTableViewController.m
//  BeaconCityGame
//
//  Created by Bartosz on 27/01/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGLastClueEditionTableViewController.h"
#import "BCGClue.h"
#import "BCGCluesManager.h"

@interface BCGLastClueEditionTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UITextField *clueDescription;

@property (assign, nonatomic, getter = isClueDescriptionFieldValid) BOOL clueDescriptionFieldValid;

@end

@implementation BCGLastClueEditionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.startButton.enabled = NO;
    
    self.majorLabel.text = [NSString stringWithFormat:@"%d", 0];
    self.minorLabel.text = [NSString stringWithFormat:@"%d", 0];
    
    [self.clueDescription addTarget:self action:@selector(clueDescriptionTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)clueDescriptionTextFieldChanged:(UITextField *)textField {
    if (textField.text.length > 0) {
        self.clueDescriptionFieldValid = YES;
    } else {
        self.clueDescriptionFieldValid = NO;
    }
    
    self.startButton.enabled = self.isClueDescriptionFieldValid;
}

- (IBAction)startTouchButton:(id)sender
{
    NSLog(@"Saved");
    BCGClue *clue = [[BCGClue alloc] initWithBeacon:nil clueDescription:self.clueDescription.text];
    
    [[BCGCluesManager sharedManager] insertObject:clue atIndex:0];
    
    [self.view endEditing:YES];
    
    [self performSegueWithIdentifier:@"showDelay" sender:nil];
    
//    [self.navigationController popViewControllerAnimated:TRUE];
}
- (IBAction)cancelTouchButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
