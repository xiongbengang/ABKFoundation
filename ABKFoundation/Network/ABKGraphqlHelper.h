//
//  ABKGraphqlHelper.h
//  ABKFoundation
//
//  Created by Bengang on 2018/6/12.
//

#import <Foundation/Foundation.h>
#import "ABKRequestItem.h"

@interface ABKGraphqlHelper : NSObject

+ (NSString *)queryStringWithRequestItems:(NSArray<ABKRequestItem *> *)requestItems apiMethod:(ABKApiMethod)apiMethod;

+ (NSString *)graphForClass:(Class)cls;

+ (NSString *)graphForClass:(Class)cls blacklist:(NSArray<NSString *> *)aBlacklist;

@end
