//
//  BCGClue.m
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 09/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGClue.h"

@interface BCGClue ()

@end

@implementation BCGClue

- (instancetype)initWithBeacon:(CLBeacon *)beacon clueDescription:(NSString *)clueDescription
{
    self = [super init];
    
    if (self) {
        self.beacon = beacon;
        self.clueDescription = clueDescription;
    }
    
    return self;
}

- (instancetype)initWithoutBeaconWithClueDescription:(NSString *)clueDescription
{
    return [self initWithBeacon:nil clueDescription:clueDescription];;
}

- (BOOL)isEqual:(id)object
{
    BCGClue *clue = object;
    if ([self.beacon.major isEqual:clue.beacon.major] && [self.beacon.minor isEqual:clue.beacon.minor]) {
        return YES;
    }
    
    return NO;
}

@end
