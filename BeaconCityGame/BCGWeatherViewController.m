//
//  BCGWeatherViewController.m
//  BeaconCityGame
//
//  Created by Bartosz on 02/02/16.
//  Copyright © 2016 Bartosz Stelmaszuk. All rights reserved.
//

#import "BCGWeatherViewController.h"
#import <OpenWeatherMapAPI/OWMWeatherAPI.h>
#import <CoreLocation/CoreLocation.h>
#import "BCGWeatherModel.h"

@interface BCGWeatherViewController ()

@property (weak, nonatomic) IBOutlet UIView *blurredView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic, strong) OWMWeatherAPI *weatherAPI;
@property (nonatomic, strong)BCGWeatherModel *weatherModel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *cloudinessLabel;
@property (weak, nonatomic) IBOutlet UILabel *rainVolumeFor3hLabel;

@end

@implementation BCGWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
    
    
    self.weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"7e025ce584c117f0f004494d2ff31e6d"];
    [self.weatherAPI setTemperatureFormat:kOWMTempCelcius];
    [self.activityIndicator startAnimating];
}

- (IBAction)cancelButtonTouch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    [self.weatherAPI currentWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSDictionary *result) {
        if (error) {
            NSLog(@" %@", error.localizedDescription);
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                           message:error.localizedDescription
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [self dismissViewControllerAnimated:YES completion:nil];
                                                           }];
            
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        self.weatherModel = [[BCGWeatherModel alloc] initWithResult:result];
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
        self.blurredView.hidden = YES;
        [self updateUIWithModel];
    }];
}

- (void)updateUIWithModel
{
    self.weatherDescriptionLabel.text = self.weatherModel.weatherDescription;
    self.cityNameLabel.text = self.weatherModel.cityName;
    self.temperatureLabel.text = self.weatherModel.temperature;
    self.humidityLabel.text = self.weatherModel.humidity;
    self.rainVolumeFor3hLabel.text = self.weatherModel.rainVolumeFor3h;
    self.pressureLabel.text = self.weatherModel.pressure;
    self.cloudinessLabel.text = self.weatherModel.cloudiness;
    
    NSURL *iconDownloadURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", self.weatherModel.iconName]];
    
    [self loadImage:iconDownloadURL];
}

- (void)loadImage:(NSURL *)imageURL
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestRemoteImage:)
                                        object:imageURL];
    [queue addOperation:operation];
}

- (void)requestRemoteImage:(NSURL *)imageURL
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    [self performSelectorOnMainThread:@selector(placeImageInUI:) withObject:image waitUntilDone:YES];
}

- (void)placeImageInUI:(UIImage *)image
{
    [self.iconImage setImage:image];
}

@end
