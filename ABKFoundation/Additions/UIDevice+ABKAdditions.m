//
//  UIDevice+BGUUID.m
//  Run
//
//  Created by Bengang on 30/11/2017.
//

#import "UIDevice+ABKAdditions.h"
#import <SAMKeychain/SAMKeychain.h>

@implementation UIDevice (ABKAdditions)

- (NSString *)abk_deviceId
{
    static NSString *deviceId = nil;
    if (!deviceId) {
        NSString *servericeKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        deviceId = [SAMKeychain passwordForService:servericeKey account:@"uuid"];
        if (!deviceId.length) {
            deviceId = [UIDevice currentDevice].identifierForVendor.UUIDString;
            deviceId = [deviceId stringByReplacingOccurrencesOfString:@"-" withString:@""];
            deviceId = [deviceId lowercaseString];
            [SAMKeychain setPassword:deviceId forService:servericeKey account:@"uuid"];
        }
    }
    return deviceId;
}

@end
