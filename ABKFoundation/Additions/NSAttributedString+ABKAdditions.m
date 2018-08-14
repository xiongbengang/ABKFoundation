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
        NSMutableDictionary *commonAttributes = [NSMutableDictionary dictionaryWithDictionary:@{NSFontAttributeName: textAttribute.font, NSForegroundColorAttributeName: textAttribute.textColor}];
        if (textAttribute.otherAttributes.count) {
            [commonAttributes addEntriesFromDictionary:textAttribute.otherAttributes];
        }
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:textAttribute.text attributes:commonAttributes];
        [attributeString appendAttributedString:attStr];
    }
    return [[NSAttributedString alloc] initWithAttributedString:attributeString];
}

@end


@implementation ABKTextAttribute

+ (instancetype)textAttributeWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    return [[ABKTextAttribute alloc] initWithText:text font:font textColor:textColor];
}

+ (instancetype)textAttributeWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor
{
    return [[ABKTextAttribute alloc] initWithText:text fontSize:fontSize textColor:textColor];
}

- (instancetype)initWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor
{
    return [self initWithText:text font:[UIFont systemFontOfSize:fontSize] textColor:textColor];
}

- (instancetype)initWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    self = [super init];
    if (self) {
        _text = [text copy];
        _font = font;
        _textColor = textColor;
    }
    return self;
}

- (UIFont *)font
{
    if (!_font) {
        _font = [UIFont systemFontOfSize:17];
    }
    return _font;
}

- (UIColor *)textColor
{
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

@end
