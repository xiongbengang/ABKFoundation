//
//  ABKOrderSegmentView.m
//  ABKUser
//
//  Created by Bengang on 2018/5/4.
//  Copyright © 2018年 Aobei Inc. All rights reserved.
//

#import "ABKOrderSegmentView.h"
#import <Masonry/Masonry.h>
#import <ABKFoundation/UIView+ABKAdditions.h>
#import "UIView+ABKSeparator.h"

@interface ABKOrderSegmentView ()

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *flagView;

@property (nonatomic, copy) NSArray<UIButton *> *buttons;
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

@end

@implementation ABKOrderSegmentView

- (void)setDelegate:(id<ABKOrderSegmentViewDelegate>)delegate
{
    _delegate = delegate;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupSubviews];
    });
}

- (NSArray<NSString *> *)segmentItems
{
    if ([self.delegate respondsToSelector:@selector(itemsForSegmentView:)]) {
        return [self.delegate itemsForSegmentView:self];
    }
    return nil;
}

- (void)reload
{
    [self setupSubviews];
}

- (void)setupSubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.backgroundColor = [UIColor whiteColor];
    NSArray<NSString *> *items = [self segmentItems];
    NSMutableArray *btns = [NSMutableArray arrayWithCapacity:items.count];
    CGFloat multiplier = 1.0/items.count;
    UIView *previousView = nil;
    for (int i = 0; i < items.count; i ++) {
        UIView *itemView = [[UIView alloc] init];
        [self addSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(multiplier);
            if (!previousView) {
                make.leading.equalTo(self);
            } else {
                make.leading.equalTo(previousView.mas_trailing);
            }
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(1.0/[UIScreen mainScreen].scale);
        }];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:self.textColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectedTextColor ?: self.textColor forState:UIControlStateSelected];
        [btn setTitle:items[i] forState:UIControlStateNormal];
        btn.titleLabel.font = self.textFont ?: [UIFont systemFontOfSize:16];
        [itemView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(itemView);
        }];
        [btns addObject:btn];
        if (i != items.count - 1 && self.showVirticalSeparator) {
            UIEdgeInsets edgeInsets = UIEdgeInsetsEqualToEdgeInsets(self.virticalSeparatorEdgeInsets, UIEdgeInsetsZero) ? UIEdgeInsetsMake(16, 0, 16, 0) : self.virticalSeparatorEdgeInsets;
            [itemView abk_addRightVerticalSeparatorWithInsets:edgeInsets];
        }
        previousView = itemView;
    }
    self.buttons = btns;
    
    self.bottomLine = [self abk_addBottomHorizontalSeparatorWithInsets:UIEdgeInsetsZero];
    self.bottomLine.hidden = YES;
    
    UIView *flagView = [[UIView alloc] init];
    [self addSubview:flagView];
    flagView.backgroundColor = self.flagColor;
    self.flagView = flagView;
    
    [self setSelectedIndex:0 animated:NO];
}

- (IBAction)buttonClick:(UIButton *)sender
{
    NSInteger btnIndex = [self.buttons indexOfObject:sender];
    [self setSelectedIndex:btnIndex animated:YES];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated
{
    if (selectedIndex >= self.buttons.count) {
        return;
    }
    UIButton *lastSelectedButton = self.buttons[self.selectedIndex];
    lastSelectedButton.selected = NO;
    lastSelectedButton.titleLabel.font = self.textFont ?: [UIFont systemFontOfSize:16];
    
    self.selectedIndex = selectedIndex;
    
    UIButton *currentSelectedButton = self.buttons[self.selectedIndex];
    currentSelectedButton.selected = YES;
    currentSelectedButton.titleLabel.font = self.selectedTextFont ?: currentSelectedButton.titleLabel.font;
    
    if (animated) {
        [UIView animateWithDuration:0.1 animations:^{
            [self.flagView mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (self.flagEqualToText) {
                    make.width.mas_equalTo(currentSelectedButton.titleLabel);
                } else {
                    make.width.equalTo(self).multipliedBy(1.0/self.buttons.count);
                }
                make.height.mas_equalTo(MAX(1, self.flagHeight));
                make.bottom.equalTo(self.bottomLine.mas_top);
                make.centerX.equalTo(currentSelectedButton.superview);
            }];
            [self layoutIfNeeded];
        }];
    } else {
        [self.flagView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self.flagEqualToText) {
                make.width.mas_equalTo(currentSelectedButton.titleLabel);
            } else {
                make.width.equalTo(self).multipliedBy(1.0/self.buttons.count);
            }
            make.height.mas_equalTo(MAX(1, self.flagHeight));
            make.bottom.equalTo(self.bottomLine.mas_top);
            make.centerX.equalTo(currentSelectedButton.superview);
        }];
    }
    if ([self.delegate respondsToSelector:@selector(segmentView:didSelectAtIndex:)]) {
        [self.delegate segmentView:self didSelectAtIndex:selectedIndex];
    }
}


@end
