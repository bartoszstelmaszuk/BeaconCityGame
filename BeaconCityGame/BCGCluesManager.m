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
@property (nonatomic) NSInteger delayTime; //in sec

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
        self.delayTime = 2;
    }
    
    return self;
}

- (void)addNextClue:(BCGClue *)clue
{
    [self.sharedCluesArray addObject:clue];
}

- (NSInteger)numberOfClues
{
    return [self.sharedCluesArray count];
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

- (void)removeObjectAtIndex:(NSUInteger)index
{
    [self.sharedCluesArray removeObjectAtIndex:index];
}

- (void)insertObject:(BCGClue *)clue atIndex:(NSUInteger)index
{
    [self.sharedCluesArray insertObject:clue atIndex:index];
}

-(void)resetClues
{
    [self.sharedCluesArray removeAllObjects];
}

-(void)setGameDelayTime:(NSInteger)delayTime
{
    self.delayTime = delayTime;
}

-(NSInteger)getDelayTime
{
    return self.delayTime;
}

@end
