//
//  NSString+ABKEncoding.h
//  ABKUser
//
//  Created by Bengang on 2018/4/23.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ABKEncoding)

+ (NSString *)abk_stringWithJSON:(id)JSONObject;

+ (NSString *)abk_stringWithBase64String:(NSString *)base64String;

- (NSString *)abk_base64String;

- (NSString *)abk_md5String;

- (NSString*)abk_SHA1;

@end
