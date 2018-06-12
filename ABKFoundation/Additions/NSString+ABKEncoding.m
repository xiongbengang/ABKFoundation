//
//  NSString+ABKEncoding.m
//  ABKUser
//
//  Created by Bengang on 2018/4/23.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "NSString+ABKEncoding.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ABKEncoding)

+ (NSString *)abk_stringWithJSON:(id)JSONObject
{
    if (!JSONObject || ![NSJSONSerialization isValidJSONObject:JSONObject]) {
        return nil;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:JSONObject options:0 error:NULL];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (NSString *)abk_stringWithBase64String:(NSString *)base64String
{
    NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSString *decodedString = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return decodedString;
}

- (NSString *)abk_base64String
{
    NSData *base64Data = [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedDataWithOptions:0];
    NSString *base64String = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return base64String;
}

- (NSString *)abk_md5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString *md5String = [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    return md5String;
}

- (NSString*)abk_SHA1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end
