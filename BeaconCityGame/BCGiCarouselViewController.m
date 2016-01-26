//
//  BCGiCarouselViewController.m
//  BeaconCityGame
//
//  Created by Bartosz on 26/01/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGiCarouselViewController.h"
#import "BCGCluesManager.h"
#import <iCarousel/iCarousel.h>

@interface BCGiCarouselViewController () <iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) IBOutlet iCarousel *carousel;

@end

@implementation BCGiCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.carousel.type = 1;
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [[BCGCluesManager sharedManager] numberOfClues];
}

-(CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return 200;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [[[BCGCluesManager sharedManager] clueAtIndex:index] clueDescription];
    
    return view;
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
