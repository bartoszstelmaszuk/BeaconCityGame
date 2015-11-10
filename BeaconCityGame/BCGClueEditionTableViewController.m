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

//- (void)setBeacon:(CLBeacon *)beacon
//{
//    self.beacon = beacon;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelTouchButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
