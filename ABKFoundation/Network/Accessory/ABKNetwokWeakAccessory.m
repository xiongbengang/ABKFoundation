//
//  ABKNetwokWeakAccessory.m
//  ABKFoundation
//
//  Created by Bengang on 2018/7/6.
//

#import "ABKNetwokWeakAccessory.h"

@implementation ABKNetwokWeakAccessory

- (instancetype)initWithAccessory:(NSObject<YTKRequestAccessory> *)accessory
{
    self = [super init];
    if (self) {
        _accessory = accessory;
    }
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL response = [super respondsToSelector:aSelector];
    if (!response) {
        response = [self.accessory respondsToSelector:aSelector];
    }
    return response;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.accessory;
}

@end
