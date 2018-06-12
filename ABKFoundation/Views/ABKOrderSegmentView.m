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

@property (nonatomic, copy) NSArray<UIButton *> *buttons;
@property (nonatomic, strong) UIView *flagView;
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

- (void)setupSubviews
{
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
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:self.textColor forState:UIControlStateNormal];
        [btn setTitle:items[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [itemView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(itemView);
        }];
        [btns addObject:btn];
        if (i != items.count - 1) {
            [itemView abk_addRightVerticalSeparatorWithInsets:UIEdgeInsetsMake(16, 0, 16, 0)];
        }
        previousView = itemView;
    }
    self.buttons = btns;
    
    UIView *bottomLine = [self abk_addBottomHorizontalSeparatorWithInsets:UIEdgeInsetsZero];
    UIView *flagView = [[UIView alloc] init];
    [self addSubview:flagView];
    flagView.backgroundColor = self.flagColor;
    [flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(multiplier);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(bottomLine);
    }];
    self.flagView = flagView;
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
    self.selectedIndex = selectedIndex;
    if (animated) {
        [UIView animateWithDuration:0.1 animations:^{
            [self.flagView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.flagView.superview).offset(selectedIndex*self.flagView.abk_width);
            }];
            [self layoutIfNeeded];
        }];
    } else {
        [self.flagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.flagView.superview).offset(selectedIndex*self.flagView.abk_width);
        }];
    }
    if ([self.delegate respondsToSelector:@selector(segmentView:didSelectAtIndex:)]) {
        [self.delegate segmentView:self didSelectAtIndex:selectedIndex];
    }
}


@end
