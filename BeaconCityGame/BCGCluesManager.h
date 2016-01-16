//
//  BCGCluesManager.h
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 09/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BCGClue.h"

@interface BCGCluesManager : NSObject

+ (id)sharedManager;
-(void)addNextClue:(BCGClue *)clue;
-(NSInteger)numberOfClues;
-(BCGClue *)clueAtIndex:(NSInteger) index;
-(BOOL)containsBeacon:(CLBeacon *)beacon;
-(void)removeObjectAtIndex:(NSUInteger)index;
-(void)insertObject:(BCGClue *)clue atIndex:(NSUInteger)index;
-(void)resetClues;
-(void)setGameDelayTime:(NSInteger)delayTime;

@end
