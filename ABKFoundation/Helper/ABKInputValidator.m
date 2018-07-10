//
//  ABKInputValidator.m
//  ABKUser
//
//  Created by Bengang on 2018/5/2.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "ABKInputValidator.h"

@implementation ABKInputValidator

+ (NSString *)stringByTrimString:(NSString *)inputText
{    
    return [inputText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber
{
    phoneNumber = [self stringByTrimString:phoneNumber];
    if (phoneNumber.length != 11) {
        return NO;
    }
    return [self isValidNumber:phoneNumber];
}

+ (BOOL)isValidSMCode:(NSString *)code
{
    code = [self stringByTrimString:code];
    if (code.length != 6) {
        return NO;
    }
    return [self isValidNumber:code];
}

+ (BOOL)isValidNumber:(NSString *)inputText
{
    NSString *trimmedString = [inputText stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (trimmedString.length) {
        return NO;
    }
    return YES;
}

// 备注：中文代码范围0x4E00~0x9FA5，
+ (BOOL)isValidChinese:(NSString *)inputText
{
    NSString *chineseRegex = @"^[\\u4e00-\\u9fa5]+$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", inputText];
    return [pre evaluateWithObject:self];
}

+ (BOOL)hasChineseText:(NSString *)inputText
{
    for(int i = 0; i < [inputText length]; i++){
        unichar c = [inputText characterAtIndex:i];
        if( c >= 0x4e00 && c <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}

@end
