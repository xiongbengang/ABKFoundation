//
//  ABKRequestItem.h
//  ABKFoundation
//
//  Created by Bengang on 2018/6/12.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ABKApiMethod) {
    ABKApiMethodQuery = 0,
    ABKApiMethodMutation = 1,
};

extern NSString *ABKApiMethodDesc(ABKApiMethod apiMethod);

@interface ABKRequestItem : NSObject

@property (nonatomic, copy) NSString *api;
@property (nonatomic, copy) NSString *graph;
@property (nonatomic, copy) NSDictionary *parameters;

+ (instancetype)requestItemWithApi:(NSString *)api parameters:(NSDictionary *)parameters graph:(NSString *)graph;

- (instancetype)initWithApi:(NSString *)api parameters:(NSDictionary *)parameters graph:(NSString *)graph;

@end

