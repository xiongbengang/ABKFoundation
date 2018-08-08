//
//  ABKJSONWrapper.m
//  ABKFoundation
//
//  Created by Bengang on 2018/8/8.
//

#import "ABKJSONWrapper.h"

@interface ABKJSONWrapper ()

@end

@implementation ABKJSONWrapper

+ (instancetype)wrapperWithJSON:(id)JSON
{
    return [[ABKJSONWrapper alloc] initWithJSON:JSON];
}

- (instancetype)initWithJSON:(id)rawJSON
{
    self = [super init];
    if (self) {
        _rawJSON = rawJSON;
    }
    return self;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    id result = nil;
    if ([self.rawJSON isKindOfClass:[NSArray class]] && idx < ((NSArray *)self.rawJSON).count) {
        result = self.rawJSON[idx];
    }
    if (result == (id)kCFNull) {
        return nil;
    }
    return [ABKJSONWrapper wrapperWithJSON:result];
}

- (id)objectForKeyedSubscript:(id<NSCopying>)key
{
    id result = nil;
    if ([self.rawJSON isKindOfClass:[NSDictionary class]]) {
        result = self.rawJSON[key];
    }
    if (result == (id)kCFNull) {
        return nil;
    }
    return [ABKJSONWrapper wrapperWithJSON:result];
}

- (NSString *)stringValue
{
    if ([self.rawJSON isKindOfClass:[NSString class]]) {
        return self.rawJSON;
    }
    if ([self.rawJSON isKindOfClass:[NSNumber class]]) {
        return [self.rawJSON stringValue];
    }
    return nil;
}

- (NSInteger)integerValue
{
    if ([self.rawJSON isKindOfClass:[NSNumber class]] ||
        [self.rawJSON isKindOfClass:[NSString class]]) {
        return [self.rawJSON integerValue];
    }
    return 0;
}

- (double)doubleValue
{
    if ([self.rawJSON isKindOfClass:[NSNumber class]] ||
        [self.rawJSON isKindOfClass:[NSString class]]) {
        return [self.rawJSON doubleValue];
    }
    return 0;
}

- (BOOL)boolValue
{
    if ([self.rawJSON isKindOfClass:[NSNumber class]] ||
        [self.rawJSON isKindOfClass:[NSString class]]) {
        return [self.rawJSON boolValue];
    }
    return 0;
}

@end
