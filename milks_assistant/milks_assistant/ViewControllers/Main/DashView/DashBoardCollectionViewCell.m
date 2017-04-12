//
//  DashBoardCollectionViewCell.m
//  MoveDemo
//
//  Created by lulu on 16/8/12.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import "DashBoardCollectionViewCell.h"

@implementation DashBoardCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds = YES; //设置为yes，就可以使用圆角
        self.layer.cornerRadius= 3; //设置它的圆角大小
        [self p_setupView];
       
    }
    return self;
}

- (void)p_setupView
{
    _labelTitle = [[UILabel alloc] init];
    [self.contentView addSubview:_labelTitle];
    
      _labelTitle.font = [UIFont boldSystemFontOfSize:15];
   
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _labelTitle.frame = CGRectMake(10*KWidth6scale, 10*KHeight6scale, self.frame.size.width-20*KWidth6scale, 20*KHeight6scale);
    
}

- (void)setTextColor:(UIColor *)color
{
    [_labelTitle setTextColor:color];
}
@end
