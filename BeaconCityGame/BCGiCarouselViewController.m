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

static NSString *const kFoundNextClue = @"kFoundNextClue";

@interface BCGiCarouselViewController () <iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UILabel *clueDescriptionLabel;
@property (strong, nonatomic) NSMutableArray *foundClues;

- (void) reloadDataWithCompletion:( void (^) (void) )completionBlock;

@end

@implementation BCGiCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.carousel.type = iCarouselTypeCoverFlow;
    self.foundClues = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFoundNextClue:)
                                                 name:kFoundNextClue
                                               object:NULL];
}

- (void)didFoundNextClue:(NSNotification *)notification;
{
    BCGClue *clue = [notification.userInfo objectForKey:@"Clue"];
    [self.foundClues addObject:clue];
    
    [self reloadDataWithCompletion:^{
        [self.carousel scrollToItemAtIndex:[self.foundClues count] animated:YES];
    }];
    
}

- (void) reloadDataWithCompletion:( void (^) (void) )completionBlock {
    [self.carousel reloadData];
    if(completionBlock) {
        completionBlock();
    }
}

#pragma iCarousel methods -

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.foundClues count];
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100.0f, 100.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:44.0f];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        label = (UILabel *)[view viewWithTag:1];
    }
    
    self.clueDescriptionLabel.text = [[self.foundClues objectAtIndex:carousel.currentItemIndex] clueDescription];
    label.text = [NSString stringWithFormat:@"%d", index + 1];
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return NO;
        }
        case iCarouselOptionSpacing:
        {
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    self.clueDescriptionLabel.text = [[self.foundClues objectAtIndex:carousel.currentItemIndex] clueDescription];
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    self.clueDescriptionLabel.text = [[self.foundClues objectAtIndex:carousel.currentItemIndex] clueDescription];
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
