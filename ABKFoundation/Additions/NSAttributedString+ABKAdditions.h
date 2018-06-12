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
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor *fontColor;

+ (instancetype)textAttributeWithText:(NSString *)text fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor;

- (instancetype)initWithText:(NSString *)text fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor;

@end
