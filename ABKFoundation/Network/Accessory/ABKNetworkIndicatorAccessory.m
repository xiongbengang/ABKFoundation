//
//  DBNetworkIndicatorAccessory.m
//  TheBarberClient
//
//  Created by Bengang on 2017/8/22.
//  Copyright © 2017年 董剑. All rights reserved.
//

#import "ABKNetworkIndicatorAccessory.h"

@implementation ABKNetworkIndicatorAccessory

#pragma mark - YTKRequestAccessory

- (void)requestWillStart:(id)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)requestWillStop:(id)request
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
