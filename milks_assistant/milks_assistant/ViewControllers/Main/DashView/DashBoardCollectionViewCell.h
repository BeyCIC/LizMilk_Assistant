//
//  DashBoardCollectionViewCell.h
//  MoveDemo
//
//  Created by lulu on 16/8/12.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashBoardCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) UILabel * labelTitle;

- (void)setTextColor:(UIColor *)color;
@end
