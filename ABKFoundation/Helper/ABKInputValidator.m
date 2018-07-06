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

+ (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber
{
    phoneNumber = [self stringByTrimString:phoneNumber];
    if (phoneNumber.length != 11) {
        return NO;
    }
    return [self isValidateNumber:phoneNumber];
}

+ (BOOL)isValidateSMCode:(NSString *)code
{
    code = [self stringByTrimString:code];
    if (code.length != 6) {
        return NO;
    }
    return [self isValidateNumber:code];
}

+ (BOOL)isValidateNumber:(NSString *)inputText
{
    NSString *trimmedString = [inputText stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (trimmedString.length) {
        return NO;
    }
    return YES;
}

@end
