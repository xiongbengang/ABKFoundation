//
//  BGNetworkBaseItem.m
//  Run
//
//  Created by Bengang on 25/11/2017.
//

#import "ABKNetworkBaseItem.h"

@implementation ABKNetworkBaseItem

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"errors": [ABKNetworkErrorItem class]};
}

@end


@implementation ABKMutationResult
@end
