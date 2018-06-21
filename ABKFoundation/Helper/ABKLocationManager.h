//
//  BGLocationManager.h
//  MemeryDemo
//
//  Created by BanvonBG on 13-12-25.
//  Copyright (c) 2013年 BanvonBG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, ABKLocationAuthorizationStatus) {
    ABKLocationAuthorizationStatusUnknown = 0,
    ABKLocationAuthorizationStatusDisabled,
    ABKLocationAuthorizationStatusAuthorized,
    ABKLocationAuthorizationStatusUnauthorized,
};

typedef void (^ABKLocationUpdateBlock) (CLLocation *aLocation, CLPlacemark *placemark);

@interface ABKLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong, readonly) CLLocation *currentLocation;

@property (nonatomic, assign, readonly) ABKLocationAuthorizationStatus authorizationStatus;

+ (ABKLocationManager *)sharedManager;

- (void)startLocationWithUpdateBlock:(ABKLocationUpdateBlock)updateBlock;

@end
