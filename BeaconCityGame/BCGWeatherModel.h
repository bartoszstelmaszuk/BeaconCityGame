//
//  BCGWeatherModel.h
//  BeaconCityGame
//
//  Created by Bartosz on 03/02/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCGWeatherModel : NSObject

@property(nonatomic ,strong, readonly) NSString *cityName;
@property(nonatomic, strong, readonly) NSString *temperature;
@property(nonatomic, strong, readonly) NSString *weatherDescription;
@property(nonatomic, strong, readonly) NSString *humidity;
@property(nonatomic, strong, readonly) NSString *pressure;
@property(nonatomic, strong, readonly) NSString *cloudiness;
@property(nonatomic, strong, readonly) NSString *rainVolumeFor3h;
@property(nonatomic, strong, readonly) NSString *iconName;

- (instancetype)initWithResult:(NSDictionary *)result;

@end
