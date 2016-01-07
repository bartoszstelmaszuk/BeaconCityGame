//
//  BCGTableViewController.m
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 06/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGTableViewController.h"
#import "BCGBeaconTableViewCell.h"
#import "BCGTableViewDataSource.h"
#import "BCGClueEditionTableViewController.h"
#import <ESTBeaconManager.h>

static const NSString *kDidRangeBeacons = @"kDidRangeBeacons";

@interface BCGTableViewController () <BCGTableViewDataSourceDelegate>

@property (strong, nonatomic) BCGTableViewDataSource *dataSource;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation BCGTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [BCGTableViewDataSource new];
    self.dataSource.delegate = self;
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.selectedIndexPath = [NSIndexPath new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BCGBeaconTableViewCell" bundle:nil] forCellReuseIdentifier:@"BCGBeaconTableViewCell"];
}

- (void)reloadTableView
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"BeaconSelection" sender:self];
}
- (IBAction)backTouchButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self.dataSource name:kDidRangeBeacons object:nil];
}


-(void)viewDidUnload
{
    [self unregisterForNotifications];
}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"BeaconSelection"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BCGClueEditionTableViewController *desViewController = segue.destinationViewController;
        desViewController.beacon = [self.dataSource getBeaconAtIndexPath:indexPath];
    }
}


@end
