//
//  BCGClue.h
//  BeaconCityGame
//
//  Created by Bartosz Stelmaszuk on 09/11/15.
//  Copyright © 2015 Bartosz Stelmaszuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ESTBeaconManager.h>

@interface BCGClue : NSObject

@property (nonatomic, strong) CLBeacon *beacon;
@property (nonatomic, strong) NSString *clueDescription;

- (instancetype)initWithBeacon:(CLBeacon *)beacon clueDescription:(NSString *)clueDescription;
@end
