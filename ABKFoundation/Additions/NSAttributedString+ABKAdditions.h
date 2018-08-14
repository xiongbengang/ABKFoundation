//
//  NSAttributedString+ABKAdditions.h
//  ABKUser
//
//  Created by Bengang on 2018/5/10.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABKTextAttribute;

@interface NSAttributedString (ABKAdditions)

+ (NSAttributedString *)abk_stringWithAttributes:(NSArray<ABKTextAttribute *> *)attributes;

@end

@interface ABKTextAttribute : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, copy) NSDictionary *otherAttributes;

+ (instancetype)textAttributeWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

+ (instancetype)textAttributeWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;

- (instancetype)initWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;

- (instancetype)initWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

@end
