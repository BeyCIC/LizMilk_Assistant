//
//  DashBoardModel.h
//  MoveDemo
//
//  Created by lulu on 16/8/1.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DashBoardModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString * Did;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * color;
@property (nonatomic,assign) NSInteger size_x;

@property (nonatomic,assign) NSInteger  size_y;

@end
