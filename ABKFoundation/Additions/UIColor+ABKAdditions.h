//
//  UIColor+ABKAdditions.h
//  ABKFoundation
//
//  Created by Bengang on 2018/6/13.
//

#import <UIKit/UIKit.h>

#define ABKColorWithHex(hex) ([UIColor abk_colorFromHexString:hex])
#define ABKColorWithRGBA(r, g, b, a) ([UIColor abk_colorWithR:r G:g B:b A:a])

@interface UIColor (ABKAdditions)

+ (instancetype)abk_colorFromHexString:(NSString *)hexString;

+ (instancetype)abk_colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;

@end
