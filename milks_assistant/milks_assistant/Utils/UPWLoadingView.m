//
//  UPWLoadingView.m
//  wallet
//
//  Created by qcao on 14/10/22.
//  Copyright (c) 2014年 JasonHuang. All rights reserved.
//

#import "UPWLoadingView.h"
#import "UPWRotateAnimationView.h"

@interface UPWLoadingView()
{
    UPWRotateAnimationView* _rotateView;
    UILabel *_textLabel;
    ELoadingStyle _loadingStyle;
}
@end

@implementation UPWLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.04];
        self.layer.cornerRadius  = 3.0;
        
        UIImage* loading = [UIImage imageNamed:@"icon_activity"];
        _rotateView = [[UPWRotateAnimationView alloc] initWithFrame:CGRectMake((frame.size.width - loading.size.width)/2, (frame.size.height - loading.size.height)/2, loading.size.width, loading.size.height)];
        _rotateView.image = loading;
        [self addSubview:_rotateView];
        
        self.text = @"正在加载";
        CGSize size = [self.text sizeWithFont:[UIFont systemFontOfSize:13]];
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_rotateView.frame)+10, size.width, size.height)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = [UIFont systemFontOfSize:13];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = UP_COL_RGB(0x999999);
        _textLabel.text = self.text;
        _textLabel.hidden = YES;
        [self addSubview:_textLabel];
        
        //默认加载方式
        _loadingStyle = ENormalLoadingStyle;
    }
    
    return self;
}

- (void)setLoadingStyle:(ELoadingStyle)style
{
    _loadingStyle = style;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    switch (_loadingStyle) {
        case ENormalLoadingStyle:
        {
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.04];
            self.layer.cornerRadius  = 3.0;
            UIImage* loading = [UIImage imageNamed:@"icon_activity"];
            _rotateView.frame = CGRectMake((self.frame.size.width - loading.size.width)/2, (self.frame.size.height - loading.size.height)/2, loading.size.width, loading.size.height);
            _textLabel.hidden = YES;
        }
            break;
        case ETextLoadingStyle:
        {
            self.backgroundColor = [UIColor clearColor];
            UIImage* loading = [UIImage imageNamed:@"icon_activity"];
            CGSize size = [self.text sizeWithFont:[UIFont systemFontOfSize:13]];
            _rotateView.frame = CGRectMake((self.frame.size.width - loading.size.width)/2, (self.frame.size.height - (loading.size.height+10+size.height))/2, loading.size.width, loading.size.height);
            _textLabel.frame = CGRectMake((CGRectGetWidth(self.frame)-size.width)/2, CGRectGetMaxY(_rotateView.frame)+10, size.width, size.height);
            _textLabel.text = self.text;
            _textLabel.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}

- (void)startAnimation
{
    [_rotateView startRotating];
}

- (void)stopAnimation
{
    [_rotateView stopRotating];
}

@end
