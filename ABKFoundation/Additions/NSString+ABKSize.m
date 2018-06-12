//
//  NSString+Size.m
//  MDF
//
//  Created by Bengang on 4/14/16.
//  Copyright © 2016 com.renrenxing. All rights reserved.
//

#import "NSString+ABKSize.h"

@implementation NSString (ABKSize)

- (CGSize)abk_sizeWithFont:(UIFont *)font
{
    return [self abk_sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (CGSize)abk_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self abk_sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)abk_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width
{
    return [self abk_sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
}

- (CGSize)abk_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self abk_sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:lineBreakMode];
}

- (CGSize)abk_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpacing:(CGFloat)lineSpacing
{
    return [self abk_sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:lineBreakMode lineSpacing:lineSpacing];
}

- (CGSize)abk_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self abk_sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode lineSpacing:-1];
}

- (CGSize)abk_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle* paragrap = [[NSMutableParagraphStyle alloc] init];
    paragrap.lineBreakMode = lineBreakMode;
    if (lineSpacing >= 0) {
        paragrap.lineSpacing = lineSpacing;
    }
    NSDictionary* attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragrap
                                 };
    return [self abk_sizeWithAttributes:attributes constrainedToSize:size];
}

- (CGSize)abk_sizeWithAttributes:(NSDictionary *)attributes constrainedToSize:(CGSize)size
{
    NSAssert(attributes, @"font 不能为nil");
    CGRect stringBound = [self boundingRectWithSize:size
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
    return CGSizeMake(ceil(stringBound.size.width), ceil(stringBound.size.height));
}

@end
