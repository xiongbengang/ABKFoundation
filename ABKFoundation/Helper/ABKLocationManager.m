//
//  BGLocationManager.m
//  MemeryDemo
//
//  Created by BanvonBG on 13-12-25.
//  Copyright (c) 2013年 BanvonBG. All rights reserved.
//

#import "ABKLocationManager.h"
#import "ABKAlertHelper.h"

@interface ABKLocationManager ()

@property (strong, nonatomic, readwrite) CLLocation *currentLocation;
@property (strong, nonatomic, readwrite) CLPlacemark *placemark;

@property (nonatomic, copy) ABKLocationUpdateBlock updateBlock;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation ABKLocationManager

+ (ABKLocationManager *)sharedManager
{
    static ABKLocationManager *locationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[ABKLocationManager alloc] init];
    });
    return locationManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1000.;
        _geocoder = [[CLGeocoder alloc] init];
    }
    return self;
}

- (ABKLocationAuthorizationStatus)authorizationStatus
{
    if (![CLLocationManager locationServicesEnabled]) {
        return ABKLocationAuthorizationStatusDisabled;
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            return ABKLocationAuthorizationStatusAuthorized;
            break;
        }
        case kCLAuthorizationStatusDenied: {
            return ABKLocationAuthorizationStatusUnauthorized;
            break;
        }
        default: {
            return ABKLocationAuthorizationStatusUnknown;
            break;
        }
    }
}

- (void)startLocationWithUpdateBlock:(ABKLocationUpdateBlock)updateBlock
{
    self.updateBlock = updateBlock;
    
    ABKLocationAuthorizationStatus authorizationStatus = self.authorizationStatus;
    if (authorizationStatus == ABKLocationAuthorizationStatusAuthorized) {
        [self.locationManager startUpdatingLocation];
    } else if (authorizationStatus == ABKLocationAuthorizationStatusUnknown){
        [self.locationManager requestWhenInUseAuthorization];
    } else if (authorizationStatus == ABKLocationAuthorizationStatusDisabled){
        [self showOpenSettingsAlert];
    } else if (authorizationStatus == ABKLocationAuthorizationStatusUnauthorized) {
        [self showOpenSettingsAlert];
    }
}

- (void)showOpenSettingsAlert
{
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [ABKAlertHelper showAlertWithTitle:@"请在系统设置中开启定位服务" message:nil actionItems:@[cancel, confirm] inController:nil];
}

- (void)stopLocationService
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *aLocation = [locations lastObject];
    _currentLocation = aLocation;
    __weak typeof(self) weakSelf = self;
    [self.geocoder reverseGeocodeLocation:aLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CLPlacemark *placemark = [placemarks firstObject];
        strongSelf.placemark = placemark;
        if (strongSelf.updateBlock) {
            strongSelf.updateBlock(aLocation, placemark);
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == ABKLocationAuthorizationStatusAuthorized) {
        [self.locationManager startUpdatingLocation];
    }
}

@end
