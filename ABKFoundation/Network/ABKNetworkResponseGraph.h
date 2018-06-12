//
//  ABKNetworkResponseGraph.h
//  ABKFoundation
//
//  Created by Bengang on 2018/6/12.
//

#import <Foundation/Foundation.h>

@protocol ABKNetworkResponseGraph <NSObject>

@optional
+ (NSArray *)graphBlacklist;

+ (NSString *)graphForProperty:(NSString *)property;

@end
