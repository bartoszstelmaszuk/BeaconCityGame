//
//  BCGWeatherModel.m
//  BeaconCityGame
//
//  Created by Bartosz on 03/02/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGWeatherModel.h"

@interface BCGWeatherModel ()

@property(nonatomic, strong, readwrite) NSString *cityName;
@property(nonatomic, strong, readwrite) NSString *temperature;
@property(nonatomic, strong, readwrite) NSString *weatherDescription;
@property(nonatomic, strong, readwrite) NSString *humidity;
@property(nonatomic, strong, readwrite) NSString *pressure;
@property(nonatomic, strong, readwrite) NSString *cloudiness;
@property(nonatomic, strong, readwrite) NSString *rainVolumeFor3h;
@property(nonatomic, strong, readwrite) NSString *iconName;

@end

@implementation BCGWeatherModel

- (instancetype)initWithResult:(NSDictionary *)result
{
    self = [super init];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    
    if (self) {
        self.cityName = result[@"name"];
        self.temperature = [NSString stringWithFormat:@"%@\u00B0", [formatter stringFromNumber:result[@"main"][@"temp"]]];
        self.pressure = [NSString stringWithFormat:@"%@ hPa", [formatter stringFromNumber:result[@"main"][@"pressure"]]];
        self.humidity = [NSString stringWithFormat:@"%@ %%", [formatter stringFromNumber:result[@"main"][@"humidity"]]];
        self.weatherDescription = [[result[@"weather"] objectAtIndex:0] objectForKey:@"description"];
        self.cloudiness = [NSString stringWithFormat:@"%@ %%", [formatter stringFromNumber:result[@"clouds"][@"all"]]];
        self.rainVolumeFor3h = [NSString stringWithFormat:@"%@ cm\u00B2", [formatter stringFromNumber:result[@"rain"][@"3h"]]];
        self.iconName = [[result[@"weather"] objectAtIndex:0] objectForKey:@"icon"];
    }
    
    return self;
}

@end
