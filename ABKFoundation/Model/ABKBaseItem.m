//
//  BGBaseItem.m
//  Run
//
//  Created by Bengang on 23/11/2017.
//

#import "ABKBaseItem.h"

@implementation ABKBaseItem

+ (instancetype)modelWithJSON:(id)JSON
{
    return [self yy_modelWithJSON:JSON];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self yy_modelSetWithDictionary:dictionary];
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    return [self yy_modelToJSONObject];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)mergeItemValue:(ABKBaseItem *)item
{
    [self yy_modelSetWithDictionary:[item toDictionary]];
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [self yy_modelCopy];
}

@end
