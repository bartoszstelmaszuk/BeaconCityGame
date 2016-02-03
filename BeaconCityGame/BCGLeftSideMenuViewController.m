//
//  BCGLeftSideMenuViewController.m
//  BeaconCityGame
//
//  Created by Bartosz on 15/01/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGLeftSideMenuViewController.h"
#import "BCGCluesManager.h"

static NSString *const kEnteredEditingMode = @"kEnteredEditingMode";

@interface BCGLeftSideMenuViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *menuTitles;
@property (strong, nonatomic) NSArray *menuImages;

@end

@implementation BCGLeftSideMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.menuTitles = @[@"Reorder Clues", @"Reset Clues", @"Delay Time", @"Weather"];
    self.menuImages =  @[@"Drag Reorder-50", @"Restart-50", @"Time-50", @"Umbrella Filled-50"];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });

    [self.view addSubview:self.tableView];
}

#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:kEnteredEditingMode object:nil];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [[BCGCluesManager sharedManager] resetClues];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self performSegueWithIdentifier:@"ShowDelayTime" sender:nil];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            [self performSegueWithIdentifier:@"showWeather" sender:nil];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.menuTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    cell.textLabel.text = self.menuTitles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.menuImages[indexPath.row]];
    
    return cell;
}

@end
