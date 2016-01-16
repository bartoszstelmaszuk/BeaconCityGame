//
//  BCGTableViewController.m
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 06/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGTableViewController.h"
#import "BCGBeaconTableViewCell.h"
#import "BCGClueTableViewCell.h"
#import "BCGTableViewDataSource.h"
#import "BCGClueEditionTableViewController.h"
#import "BCGCluesManager.h"
#import <EstimoteSDK/ESTBeaconManager.h>
#import <RESideMenu/UIViewController+RESideMenu.h>
#import "RESideMenu.h"

static const NSString *kDidRangeBeacons = @"kDidRangeBeacons";

@interface BCGTableViewController () <BCGTableViewDataSourceDelegate>

@property (strong, nonatomic) BCGTableViewDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reorderCluesButton;

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BCGBeaconTableViewCell" bundle:nil] forCellReuseIdentifier:@"BCGBeaconTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BCGClueTableViewCell" bundle:nil] forCellReuseIdentifier:@"BCGClueTableViewCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView.dataSource
                                             selector:@selector(didRangeBeacons:)
                                                 name:kDidRangeBeacons
                                               object:nil];
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
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"BeaconSelection" sender:self];
    }
}

- (IBAction)sideMenuTouchButton:(id)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)editTouchButton:(id)sender {
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:NO];
        [self.tableView reloadData];
        self.reorderCluesButton.title = @"Reorder Clues";
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        self.reorderCluesButton.title = @"Done";
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(void)unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self.dataSource name:kDidRangeBeacons object:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 && [self.dataSource.beacons count] == 0) {
        return 0;
    } else if (section == 1 && [[BCGCluesManager sharedManager] numberOfClues] == 0) {
        return 0;
    }
    
    return 25.f;
}

-(void)viewDidUnload
{
    [self unregisterForNotifications];
}


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
