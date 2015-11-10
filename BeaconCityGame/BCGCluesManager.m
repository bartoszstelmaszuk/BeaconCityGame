//
//  BCGCluesManager.m
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 09/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGCluesManager.h"

@interface BCGCluesManager ()

@property (nonatomic, strong) NSMutableArray *sharedCluesArray;

@end

@implementation BCGCluesManager

+ (id)sharedManager
{
    static BCGCluesManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [BCGCluesManager new];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.sharedCluesArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)addNextClue:(BCGClue *)clue
{
    [self.sharedCluesArray addObject:clue];
}

- (NSInteger)numberOfClues
{
    return self.sharedCluesArray.count;
}

- (BCGClue *)clueAtIndex:(NSInteger)index
{
    return self.sharedCluesArray[index];
}

- (BOOL)containsBeacon:(CLBeacon *)beacon
{
    BOOL contains = NO;
    for (BCGClue *clue in self.sharedCluesArray)
    {
        if ([clue.beacon.major isEqual:beacon.major] && [clue.beacon.minor isEqual:beacon.minor]) {
            contains = YES;
        }
    }
    
    return contains;
}
@end
