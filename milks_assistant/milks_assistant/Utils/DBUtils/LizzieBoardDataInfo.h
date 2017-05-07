//
//  DWTimingDataInfo.h
//  DearWhere
//
//  Created by lgp on 13-12-19.
//  Copyright (c) 2013年 lgp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBConnection.h"
#import "FMResultSet.h"

#import "DashBoardModel.h"
 
@interface LizzieBoardDataInfo : NSObject
{
}

-(void)saveDiary:(DashBoardModel *)DiaryData;
+(NSArray *)getBoardObjects;
-(NSMutableArray *)getBoardObjectsbByDate:(NSString *)date;
-(int)getTimingObjectsNum:(NSString *)f_account;
-(void)deleteTimer:(NSString *)f_accoutName;
-(void)updateTimer:(NSString *)daily1 enabled:(NSString *)enabled1 endTime:(NSString *)endTime1 openTime:(NSString *)openTime1 periodName:(NSString *)periodName1 seq:(NSString *)seq1 spaceTime:(NSString *)spaceTime1 upTime:(NSString *)upTime1;
//添加定时器
-(void)addDiary:(DashBoardModel *)DiaryData;
//update
-(void)updateDashBoard:(DashBoardModel *)timingData;
//更新定时器－queryall
-(void)updateTimingALL:(DashBoardModel*)DiaryData;
//删除定时器－queryall
-(void)deleteTimingAll:(DashBoardModel*)DiaryData;
-(void)deleteTimingAll;
@end

