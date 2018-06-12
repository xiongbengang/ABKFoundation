//
//  ABKRequestItem.m
//  ABKFoundation
//
//  Created by Bengang on 2018/6/12.
//

#import "ABKRequestItem.h"
#import "ABKBaseItem.h"

NSString *ABKApiMethodDesc(ABKApiMethod apiMethod) {
    switch (apiMethod) {
        case ABKApiMethodQuery: {
            return @"query";
        }
        case ABKApiMethodMutation: {
            return @"mutation";
        }
        default: {
            return @"query";
        }
    }
}

@implementation ABKRequestItem

+ (instancetype)requestItemWithApi:(NSString *)api parameters:(NSDictionary *)parameters graph:(NSString *)graph
{
    return [[self alloc] initWithApi:api parameters:parameters graph:graph];
}

- (instancetype)initWithApi:(NSString *)api parameters:(NSDictionary *)parameters graph:(NSString *)graph
{
    self = [super init];
    if (self) {
        _api = [api copy];
        _parameters = [parameters copy];
        _graph = [graph copy];
    }
    return self;
}

@end
