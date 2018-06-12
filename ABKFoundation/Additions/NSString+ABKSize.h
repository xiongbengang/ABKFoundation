//
//  NSString+Size.h
//  MDF
//
//  Created by Bengang on 4/14/16.
//  Copyright © 2016 com.renrenxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (ABKSize)

- (CGSize)abk_sizeWithFont:(UIFont *)font;

- (CGSize)abk_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize)abk_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width;

- (CGSize)abk_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)abk_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpacing:(CGFloat)lineSpacing;

- (CGSize)abk_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)abk_sizeWithAttributes:(NSDictionary *)attributes constrainedToSize:(CGSize)size;

@end
