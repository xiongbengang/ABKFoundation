//
//  BGFakeNavigationBar.m
//  Kiwi
//
//  Created by Bengang on 2018/5/28.
//

#import "ABKFakeNavigationBar.h"
#import <Masonry/Masonry.h>
#import "UIView+ABKAdditions.h"

@implementation ABKFakeNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, ABKScreenWidth, ABKNavigationTopHeight)];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectZero];
    statusBarView.backgroundColor = [UIColor clearColor];
    [self addSubview:statusBarView];
    [statusBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(ABKStatusBarHeight);
    }];
    _statusBarView = statusBarView;
    
    UIView *barContentView = [[UIView alloc] init];
    barContentView.backgroundColor = [UIColor clearColor];
    [self addSubview:barContentView];
    [barContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-ABKSeparatorHeight);
        make.top.equalTo(statusBarView.mas_bottom);
    }];
    _contentView = barContentView;
    
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
    [self addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ABKSeparatorHeight);
        make.leading.trailing.bottom.equalTo(self);
    }];
    _bottomLine = separator;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [self addLeftView:backButton];
    _backButton = backButton;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    [self addTitleView:titleLabel];
    _titleLabel = titleLabel;
}

- (void)addTitleView:(UIView *)titleView
{
    [self.contentView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView).multipliedBy(2.0/3).priorityLow();
        make.height.mas_equalTo(self.contentView).multipliedBy(0.9).priorityLow();
    }];
    [titleView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [titleView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)addLeftView:(UIView *)leftView
{
    [self.contentView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        CGFloat width = MIN(leftView.abk_width, 100);
        CGFloat height = MIN(leftView.abk_height, ABKNavigationBarHeight*0.9);
        make.width.mas_equalTo(width).priorityLow();
        make.height.mas_equalTo(height).priorityLow();
    }];
    [leftView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [leftView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)addRightView:(UIView *)rightView
{
    [self.contentView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        CGFloat width = MIN(rightView.abk_width, 100);
        CGFloat height = MIN(rightView.abk_height, ABKNavigationBarHeight*0.9);
        make.width.mas_equalTo(width).priorityLow();
        make.height.mas_equalTo(height).priorityLow();
    }];
    [rightView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [rightView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setLeftView:(UIView *)leftView
{
    if (_leftView == leftView) {
        return;
    }
    [_leftView removeFromSuperview];
    self.backButton.hidden = YES;
    
    _leftView = leftView;
    
    if (leftView) {
        [self addLeftView:leftView];
    }
}

- (void)setRightView:(UIView *)rightView
{
    if (_rightView == rightView) {
        return;
    }
    [_rightView removeFromSuperview];
    
    _rightView = rightView;
    
    if (rightView) {
        [self addRightView:rightView];
    }
}

- (void)setTitleView:(UIView *)titleView
{
    if (_titleView == titleView) {
        return;
    }
    [_titleView removeFromSuperview];
    _titleLabel.hidden = YES;
    
    _titleView = titleView;
    
    if (titleView) {
        [self addTitleView:titleView];
    }
}

@end
