//
//  ABKInputValidator.m
//  ABKUser
//
//  Created by Bengang on 2018/5/2.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "ABKInputValidator.h"

@implementation ABKInputValidator

+ (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber
{
    if (phoneNumber.length != 11) {
        return NO;
    }
    NSString *trimmedString = [phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (trimmedString.length) {
        return NO;
    }
    return YES;
}

@end
