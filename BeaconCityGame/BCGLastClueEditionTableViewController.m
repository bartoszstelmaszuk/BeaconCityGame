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

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
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
