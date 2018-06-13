//
//  UIColor+ABKAdditions.m
//  ABKFoundation
//
//  Created by Bengang on 2018/6/13.
//

#import "UIColor+ABKAdditions.h"

@implementation UIColor (ABKAdditions)

#pragma mark - Color from Hex
+ (instancetype)abk_colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];    
    return [[self class] abk_colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:1.0];
}

+ (instancetype)abk_colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha
{
    return [[self class] colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

@end
