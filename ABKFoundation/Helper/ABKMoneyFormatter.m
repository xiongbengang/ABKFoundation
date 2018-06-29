//
//  ABKMoneyFormatter.m
//  ABKFoundation
//
//  Created by Bengang on 2018/6/28.
//

#import "ABKMoneyFormatter.h"

@implementation ABKMoneyFormatter

+ (NSString *)stringWithMoney:(NSInteger)money
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *num = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:money/100.]];
    return num;
}

+ (NSString *)decimalStringWithMoney:(NSInteger)money
{
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    [moneyFormatter setPositiveFormat:@"###,##0.00"];
    NSString *rs = [moneyFormatter stringFromNumber:[NSNumber numberWithFloat:money/100.]];
    return rs;
}

@end
