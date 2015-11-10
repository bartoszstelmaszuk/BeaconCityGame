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

@end
