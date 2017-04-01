//
//  DWTimingDataInfo.m
//  DearWhere
//
//  Created by lgp on 13-12-19.
//  Copyright (c) 2013年 lgp. All rights reserved.
//

#import "DWTimingDataInfo.h"
 
@implementation DWTimingDataInfo
@synthesize account,daily,enabled,endTime,f_account,openTime,periodName,periodNo,seq,spaceTime,timeCoder,upTime;
@synthesize timingSeqArray;

//更新定时器－queryall
-(void)updateTimingALL:(LizzieDiaryModel*)data
{
    self.timingSeqArray = [[NSMutableArray alloc]initWithCapacity:1];
    for (DWTimingDataInfo *timingSeq in [DWTimingDataInfo getTimingObjects]) {
        [self.timingSeqArray addObject:[timingSeq seq]];
    }
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:@"DearWhere_S.sqlite"];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
    if ([dbConnection isTableOK:@"DWTiming"]) {
//    for (int i= 0; i < [data.timingFriendDataListTwo count]; i++) {
//        //如果包含此seq,则做更新处理,反之做插入操作,防止不同手机登录
//        if ([self.timingSeqArray containsObject:[(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] seq]]) {
//            self.account = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] account];
//            self.daily = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] daily];
//            self.enabled = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] enabled];
//            self.endTime = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] endTime];
//            self.f_account = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] f_account];
//            self.openTime = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] openTime];
//            self.periodName = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] periodName];
//            self.periodNo = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] periodNo];
//            self.seq = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] seq];
//            self.spaceTime = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] spaceTime];
//            self.timeCoder = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] timeCoder];
//            self.upTime = [(FriendTimingDada *)[data.timingFriendDataListTwo objectAtIndex:i] upTime];
//            
//            BOOL  update =  [[dbConnection DB] executeUpdate:@"update DWTiming set account = ?,daily = ?,enabled = ?,endTime = ?,f_account = ?,openTime = ?,periodName = ?,periodNo = ?,spaceTime = ?,timeCoder = ?,upTime = ? where seq = ?",self.account,self.daily,self.enabled,self.endTime,self.f_account,self.openTime,self.periodName,self.periodNo,self.spaceTime,self.timeCoder,self.upTime,self.seq];
//            if (update) {
//                NSLog(@"重新定时器成功");
//            }
//        }
//    }
  }
    [[dbConnection DB] close];
}
//删除定时器－queryall
-(void)deleteTimingAll:(LizzieDiaryModel*)data
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:@"DearWhere_S.sqlite"];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
//    if ([dbConnection isTableOK:@"DWTiming"]) {
//        for (int i= 0; i < [data.timingFriendDataListOne  count]; i++) {
//             self.seq = [(UpdateTimerData *)[data.timingFriendDataListOne  objectAtIndex:i] seq];
//            BOOL  delete=  [[dbConnection DB] executeUpdate:@"delete from DWTiming where seq = ?",seq];
//            
//            if (delete) {
//                NSLog(@"删除定时器成功");
//            }
//        }
//    }
   
    [[dbConnection DB] close];
}

//定时器全删除
-(void)deleteTimingAll
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:@"DearWhere_S.sqlite"];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
    if ([dbConnection isTableOK:@"DWTiming"]) {
        BOOL  delete=  [[dbConnection DB] executeUpdate:@"delete from DWTiming"];
        if (delete) {
            NSLog(@"删除定时器成功");
        }
    }
    
    [[dbConnection DB] close];
}
//添加定时器
-(void)addTimingLoc:(LizzieDiaryModel *)timingData
{
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:@"DearWhere_S.sqlite"];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    if (![dbConnection isTableOK:@"DWTiming"]) {
        [dbConnection createTable:@"DWTiming" withArguments:@"account text,daily text,enabled text,endTime text,f_account text,openTime text,periodName text,periodNo text,seq text,spaceTime text,timeCoder text,upTime text"];
    }
    
//    self.account =    [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] account];
//    self.daily =      [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] daily];
//    self.enabled =    [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] enabled];
//    self.endTime =    [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] endTime];
//    self.f_account =  [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] f_account];
//    self.openTime =   [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] openTime];
//    self.periodName = [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] periodName];
//    self.periodNo =   [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] periodNo];
//    self.seq =        [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] seq];
//    self.spaceTime =  [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] spaceTime];
//    self.timeCoder =  [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] timeCoder];
//    self.upTime =     [(UpdateTimerData *)[timingData.UpdateTimerResDataList objectAtIndex:0] upTime];
//    
//    
//    BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into DWTiming values(?,?,?,?,?,?,?,?,?,?,?,?)",account,daily,enabled,endTime,f_account,openTime,periodName,periodNo,seq,spaceTime,timeCoder,upTime];
//    if (insert) {
//        NSLog(@"重新插入数据库成功");
//    }
//    [[dbConnection DB] close];
}
//queryall
-(void)saveTimingLoc:(LizzieDiaryModel *)timingData
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:@"DearWhere_S.sqlite"];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    
//    if ([dbConnection isTableOK:@"DWTiming"]) {
//        for (int i= 0; i < [timingData.timingFriendDataListZero count]; i++) {
//            //如果包含此seq,则做更新处理,反之做插入操作,防止不同手机登录
//            self.account = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] account];
//            self.daily = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] daily];
//            self.enabled = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] enabled];
//            self.endTime = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] endTime];
//            self.f_account = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] f_account];
//            self.openTime = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] openTime];
//            self.periodName = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] periodName];
//            self.periodNo = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] periodNo];
//            self.seq = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] seq];
//            self.spaceTime = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] spaceTime];
//            self.timeCoder = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] timeCoder];
//            self.upTime = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] upTime];
//            
//            BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into DWTiming values(?,?,?,?,?,?,?,?,?,?,?,?)",self.account,self.daily,self.enabled,self.endTime,self.f_account,self.openTime,self.periodName,self.periodNo,self.seq,self.spaceTime,self.timeCoder,self.upTime];
//            if (insert) {
//                NSLog(@"新增定时器成功");
//            }
//        }
//    }else{
//        
//        [dbConnection createTable:@"DWTiming" withArguments:@"account text,daily text,enabled text,endTime text,f_account text,openTime text,periodName text,periodNo text,seq text,spaceTime text,timeCoder text,upTime text"];
//        
//        for (int i=0; i<[timingData.timingFriendDataListZero count]; i++) {
//            self.account = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] account];
//            self.daily = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] daily];
//            self.enabled = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] enabled];
//            self.endTime = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] endTime];
//            self.f_account = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] f_account];
//            self.openTime = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] openTime];
//            self.periodName = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] periodName];
//            self.periodNo = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] periodNo];
//            self.seq = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] seq];
//            self.spaceTime = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] spaceTime];
//            self.timeCoder = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] timeCoder];
//            self.upTime = [(FriendTimingDada *)[timingData.timingFriendDataListZero objectAtIndex:i] upTime];
//            
//            BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into DWTiming values(?,?,?,?,?,?,?,?,?,?,?,?)",self.account,self.daily,self.enabled,self.endTime,self.f_account,self.openTime,self.periodName,self.periodNo,self.seq,self.spaceTime,self.timeCoder,self.upTime];
//            if (insert) {
//                NSLog(@"定时器插入数据库成功");
//            }
//        }
//    }
    [[dbConnection DB] close];
}

-(int)getTimingObjectsNum:(NSString *)f_account1
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:@"DearWhere_S.sqlite"];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    FMResultSet *result = [[dbConnection DB] executeQuery:@"select count(*) from DWTiming where f_account = ? and spaceTime<>''",f_account1];
    int num = 0;
    if ([result next]) {
        num = [result intForColumnIndex:0];
    }
    [[dbConnection DB] close];
    return num;
}

-(NSMutableArray *)getTimingObjects:(NSString *)f_account1
{
    NSMutableArray *userArray = [[NSMutableArray alloc]initWithCapacity:1];
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:@"DearWhere_S.sqlite"];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    FMResultSet *result = [[dbConnection DB] executeQuery:@"select * from DWTiming where f_account = ?",f_account1];
    while ([result next]) {
        DWTimingDataInfo  *pTimerDataInfo = [[DWTimingDataInfo alloc]init];
        
        pTimerDataInfo.account = [result stringForColumn:@"account"];
        pTimerDataInfo.daily = [result stringForColumn:@"daily"];
        pTimerDataInfo.enabled = [result stringForColumn:@"enabled"];
        pTimerDataInfo.endTime = [result stringForColumn:@"endTime"];
        pTimerDataInfo.f_account = [result stringForColumn:@"f_account"];
        pTimerDataInfo.openTime = [result stringForColumn:@"openTime"];
        pTimerDataInfo.periodName = [result stringForColumn:@"periodName"];
        pTimerDataInfo.periodNo = [result stringForColumn:@"periodNo"];
        pTimerDataInfo.seq = [result stringForColumn:@"seq"];
        pTimerDataInfo.spaceTime = [result stringForColumn:@"spaceTime"];
        pTimerDataInfo.timeCoder = [result stringForColumn:@"timeCoder"];
        pTimerDataInfo.upTime = [result stringForColumn:@"upTime"];
        
        //NSLog(@"姓名:%@,性别:%@,年龄%@:",pUserDataInfo.seq,pUserDataInfo.daily,pUserDataInfo.upTime);
        [userArray addObject:pTimerDataInfo];
        
    }
    
    [[dbConnection DB] close];
    
    return userArray;
}

//删除定时器
-(void)deleteTimer:(NSString *)seqName
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:@"DearWhere_S.sqlite"];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
    
    BOOL  delete=  [[dbConnection DB] executeUpdate:@"delete from DWTiming where seq = ?",seqName];
    
    if (delete) {
        NSLog(@"本地数据库删除定时器成功");
    }
    [[dbConnection DB] close];
}
//更新定时器
-(void)updateTimer:(NSString *)daily1 enabled:(NSString *)enabled1 endTime:(NSString *)endTime1 openTime:(NSString *)openTime1 periodName:(NSString *)periodName1 seq:(NSString *)seq1 spaceTime:(NSString *)spaceTime1 upTime:(NSString *)upTime1
{
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:@"DearWhere_S.sqlite"];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
    
    BOOL  update =  [[dbConnection DB] executeUpdate:@"update DWTiming set daily = ? ,enabled = ? ,endTime = ?,openTime = ? ,periodName = ? ,spaceTime = ? ,upTime = ?  where seq = ?",daily1,enabled1,endTime1,openTime1,periodName1,spaceTime1,upTime1,seq1];
    
    if (update) {
        NSLog(@"更新定时器成功");
    }
    [[dbConnection DB] close];
}
+(NSArray *)getTimingObjects
{
NSMutableArray *userArray = [[NSMutableArray alloc]initWithCapacity:1];

DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:@"DearWhere_S.sqlite"];
[dbConnection readyDatabse];
if (![[dbConnection DB] open]) {
    NSLog(@"数据库没有打开");
}

FMResultSet *result = [[dbConnection DB] executeQuery:@"select * from DWTiming"];
while ([result next]) {
    DWTimingDataInfo  *pTimerDataInfo = [[DWTimingDataInfo alloc]init];
    
    pTimerDataInfo.account = [result stringForColumn:@"account"];
    pTimerDataInfo.daily = [result stringForColumn:@"daily"];
    pTimerDataInfo.enabled = [result stringForColumn:@"enabled"];
    pTimerDataInfo.endTime = [result stringForColumn:@"endTime"];
    pTimerDataInfo.f_account = [result stringForColumn:@"f_account"];
    pTimerDataInfo.openTime = [result stringForColumn:@"openTime"];
    pTimerDataInfo.periodName = [result stringForColumn:@"periodName"];
    pTimerDataInfo.periodNo = [result stringForColumn:@"periodNo"];
    pTimerDataInfo.seq = [result stringForColumn:@"seq"];
    pTimerDataInfo.spaceTime = [result stringForColumn:@"spaceTime"];
    pTimerDataInfo.timeCoder = [result stringForColumn:@"timeCoder"];
    pTimerDataInfo.upTime = [result stringForColumn:@"upTime"];
    
    //NSLog(@"姓名:%@,性别:%@,年龄%@:",pUserDataInfo.seq,pUserDataInfo.daily,pUserDataInfo.upTime);
    [userArray addObject:pTimerDataInfo];
    
}

[[dbConnection DB] close];

return userArray;
}
@end
