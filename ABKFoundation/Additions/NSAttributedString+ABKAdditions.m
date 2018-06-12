//
//  NSAttributedString+ABKAdditions.m
//  ABKUser
//
//  Created by Bengang on 2018/5/10.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "NSAttributedString+ABKAdditions.h"

@implementation NSAttributedString (ABKAdditions)

+ (NSAttributedString *)abk_stringWithAttributes:(NSArray<ABKTextAttribute *> *)attributes
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] init];
    for (ABKTextAttribute *textAttribute in attributes) {
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:textAttribute.text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textAttribute.fontSize], NSForegroundColorAttributeName: textAttribute.fontColor}];
        [attributeString appendAttributedString:attStr];
    }
    return [[NSAttributedString alloc] initWithAttributedString:attributeString];
}

@end


@implementation ABKTextAttribute

+ (instancetype)textAttributeWithText:(NSString *)text fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor
{
    return [[self alloc] initWithText:text fontSize:fontSize fontColor:fontColor];
}

- (instancetype)initWithText:(NSString *)text fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor
{
    self = [super init];
    if (self) {
        _text = [text copy];
        _fontSize = fontSize;
        _fontColor = fontColor;
    }
    return self;
}

- (CGFloat)fontSize
{
    if (_fontSize <= 0) {
        _fontSize = 17;
    }
    return _fontSize;
}

- (UIColor *)fontColor
{
    if (!_fontColor) {
        _fontColor = [UIColor blackColor];
    }
    return _fontColor;
}

@end
