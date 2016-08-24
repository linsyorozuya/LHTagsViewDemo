//
//  HistoryHeadCollectionReusableView.m
//  HappyStudy
//
//  Created by Lin on 16/8/22.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "HistoryHeadCollectionReusableView.h"
@interface HistoryHeadCollectionReusableView ()

@property (strong,nonatomic) UILabel* textLabel;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIButton *delectButton;
@end

@implementation HistoryHeadCollectionReusableView
- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.textLabel];
        [self addSubview:self.delectButton];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.delectButton.frame = CGRectMake(self.frame.size.width - 50, (self.frame.size.height - 30.0f) / 2, 50, 30);
}

- (void)delect
{
    if ([self.delectDelegate respondsToSelector:@selector(delectData)]) {
        [self.delectDelegate delectData];
    }
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

#pragma mark - setter &getter

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(18 +5.0f, (self.frame.size.height - 18.0f) / 2, 100.0f, 18)];
        _textLabel.textColor = [UIColor colorWithWhite:0.294 alpha:1.000];
        _textLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _textLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, (self.frame.size.height - 18.0f )/ 2, 18, 18)];
    }
    return _imageView;
}

- (UIButton *)delectButton
{
    if (!_delectButton)
    {
        _delectButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 50, (self.frame.size.height - 30.0f) / 2, 50, 30)];
        [_delectButton setTitleColor:[UIColor colorWithWhite:0.498 alpha:1.000] forState:UIControlStateNormal];
        [_delectButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_delectButton setTitle:@"清空" forState:UIControlStateNormal];
        [_delectButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_delectButton addTarget:self action:@selector(delect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delectButton;
}

- (void) setText:(NSString*)text
{
    self.textLabel.text = text;
}

- (void) setImage:(NSString *)image;
{
    [self.imageView setImage:[UIImage imageNamed:image]];
}



@end
