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
+ (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber;

// 是否是合法的验证码
+ (BOOL)isValidateSMCode:(NSString *)code;

+ (BOOL)isValidateNumber:(NSString *)inputText;

@end
