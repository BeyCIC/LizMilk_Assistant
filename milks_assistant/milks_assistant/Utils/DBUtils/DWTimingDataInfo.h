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

#import "LizzieDiaryModel.h"
 
@interface DWTimingDataInfo : NSObject
{
    NSString *account;
    NSString *daily;
    NSString *enabled;
    NSString *endTime;
    NSString *f_account;
    NSString *openTime;
    NSString *periodName;
    NSString *periodNo;
    NSString *seq;
    NSString *spaceTime;
    NSString *timeCoder;
    NSString *upTime;
    NSMutableArray *timingSeqArray;
}
@property(strong,nonatomic)NSMutableArray *timingSeqArray;
@property(strong,nonatomic)NSString *account;
@property(strong,nonatomic)NSString *daily;
@property(strong,nonatomic)NSString *enabled;
@property(strong,nonatomic)NSString *endTime;
@property(strong,nonatomic)NSString *f_account;
@property(strong,nonatomic)NSString *openTime;
@property(strong,nonatomic)NSString *periodName;
@property(strong,nonatomic)NSString *periodNo;
@property(strong,nonatomic)NSString *seq;
@property(strong,nonatomic)NSString *spaceTime;
@property(strong,nonatomic)NSString *timeCoder;
@property(strong,nonatomic)NSString *upTime;

-(void)saveDiary:(LizzieDiaryModel *)DiaryData;
+(NSArray *)getTimingObjects;
-(NSMutableArray *)getTimingObjects:(NSString *)f_account;
-(int)getTimingObjectsNum:(NSString *)f_account;
-(void)deleteTimer:(NSString *)f_accoutName;
-(void)updateTimer:(NSString *)daily1 enabled:(NSString *)enabled1 endTime:(NSString *)endTime1 openTime:(NSString *)openTime1 periodName:(NSString *)periodName1 seq:(NSString *)seq1 spaceTime:(NSString *)spaceTime1 upTime:(NSString *)upTime1;
//添加定时器
-(void)addDiary:(LizzieDiaryModel *)DiaryData;
//更新定时器－queryall
-(void)updateTimingALL:(LizzieDiaryModel*)DiaryData;
//删除定时器－queryall
-(void)deleteTimingAll:(LizzieDiaryModel*)DiaryData;
-(void)deleteTimingAll;
@end

