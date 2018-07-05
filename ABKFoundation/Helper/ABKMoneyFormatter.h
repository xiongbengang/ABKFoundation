//
//  ABKMoneyFormatter.h
//  ABKFoundation
//
//  Created by Bengang on 2018/6/28.
//

#import <Foundation/Foundation.h>

@interface ABKMoneyFormatter : NSObject

+ (NSString *)stringWithMoney:(NSInteger)money;

+ (NSString *)decimalStringWithMoney:(NSInteger)money;

+ (NSString *)symbolPrefixMoneyString:(NSInteger)money;

+ (NSString *)symbolPrefixDecimalMoneyString:(NSInteger)money;

@end
