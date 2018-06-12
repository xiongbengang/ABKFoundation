//
//  ABKNetworkErrorItem.m
//  ABKUser
//
//  Created by Bengang on 2018/4/26.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "ABKNetworkErrorItem.h"

@implementation ABKNetworkErrorItem

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"errDescription": @"description"};
}

@end
