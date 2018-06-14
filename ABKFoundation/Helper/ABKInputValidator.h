//
//  ABKInputValidator.h
//  ABKUser
//
//  Created by Bengang on 2018/5/2.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABKInputValidator : NSObject

// 仅简单判断长度是否等于11
+ (BOOL)isValidatePhoneNumber:(NSString *)phoneNumber;

@end
