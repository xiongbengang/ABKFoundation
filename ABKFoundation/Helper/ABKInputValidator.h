//
//  ABKInputValidator.h
//  ABKUser
//
//  Created by Bengang on 2018/5/2.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABKInputValidator : NSObject

+ (NSString *)stringByTrimString:(NSString *)inputText;

// 仅简单判断长度是否等于11
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber;

// 是否是合法的验证码
+ (BOOL)isValidSMCode:(NSString *)code;

// 纯数字
+ (BOOL)isValidNumber:(NSString *)inputText;

// 纯汉字
+ (BOOL)isValidChinese:(NSString *)inputText;

// 是否包含汉字
+ (BOOL)hasChineseText:(NSString *)inputText;

@end
