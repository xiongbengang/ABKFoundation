//
//  ABKViewControllerBottomView.m
//  ABKFoundation
//
//  Created by Bengang on 2018/6/25.
//

#import "ABKViewControllerBottomView.h"
#import <Masonry/Masonry.h>
#import "UIView+ABKAdditions.h"
#import <Masonry/Masonry.h>

@interface ABKViewControllerBottomView ()

@property (nonatomic, assign) UIEdgeInsets contentViewInsets;
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation ABKViewControllerBottomView

- (instancetype)initWithContentView:(UIView *)contentView
                      contentHeight:(CGFloat)contentHeight
                      contentInsets:(UIEdgeInsets)contentInsets
{
    UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].keyWindow.abk_safeAreaInsets;
    CGFloat excludeSafeAreaHeight = contentHeight + contentInsets.top + contentInsets.bottom;
    CGFloat height = excludeSafeAreaHeight + safeAreaInsets.bottom;
    
    self = [super initWithFrame:CGRectMake(0, 0, ABKScreenWidth, height)];
    if (self) {
        _contentView = contentView;
        _contentViewInsets = contentInsets;
        _contentHeight = contentHeight;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.contentViewInsets.left);
        make.right.equalTo(self).offset(-self.contentViewInsets.right);
        make.top.equalTo(self).offset(self.contentViewInsets.top);
        make.height.mas_equalTo(self.contentHeight);
    }];
}

- (CGFloat)excludeSafeAreaHeight
{
    return self.contentHeight + self.contentViewInsets.top + self.contentViewInsets.bottom;
}

@end
