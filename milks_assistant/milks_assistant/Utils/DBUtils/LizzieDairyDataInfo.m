//
//  DWTimingDataInfo.m
//  DearWhere
//
//  Created by lgp on 13-12-19.
//  Copyright (c) 2013年 lgp. All rights reserved.
//

#import "LizzieDairyDataInfo.h"
 
@implementation LizzieDairyDataInfo

//@property (nonatomic, copy) NSString<Optional>* userId;
//@property (nonatomic, copy) NSString<Optional>* userName;
//@property (nonatomic, copy) NSString<Optional>* diaryContent;
//@property (nonatomic, copy) NSString<Optional>* mood;
//@property (nonatomic, copy) NSString<Optional>* time;
//@property (nonatomic, copy) NSString<Optional>* location;

//更新定时器－queryall
-(void)updateTimingALL:(LizzieDiaryModel*)data
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
    if ([dbConnection isTableOK:TABLE_NAME_DIARY]) {

        BOOL  update =  [[dbConnection DB] executeUpdate:@"update Lizziediary set account = ?,userId = ?,userName = ?,diaryContent = ?,mood = ?,date = ?,location = ?",data.userId,data.userName,data.diaryContent,data.mood,data.time,data.location];
        if (update) {
            NSLog(@"insert dairy success");
        }
    }
    [[dbConnection DB] close];
}
    
//删除定时器－queryall
-(void)deleteTimingAll:(LizzieDiaryModel*)data
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
    if ([dbConnection isTableOK:TABLE_NAME_DIARY]) {
        
            NSString *dairyDate = data.time;
            BOOL  delete=  [[dbConnection DB] executeUpdate:@"delete from Lizziediary where date = ?",dairyDate];
            
            if (delete) {
                NSLog(@"删除定时器成功");
            }
    }
   
    [[dbConnection DB] close];
}

//定时器全删除
-(void)deleteDairyAll
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
    if ([dbConnection isTableOK:TABLE_NAME_DIARY]) {
        BOOL  delete=  [[dbConnection DB] executeUpdate:@"delete from Dairy"];
        if (delete) {
            NSLog(@"删除定时器成功");
        }
    }
    
    [[dbConnection DB] close];
}
//添加定时器
-(void)addTimingLoc:(LizzieDiaryModel *)timingData
{
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    if (![dbConnection isTableOK:TABLE_NAME_DIARY]) {
        [dbConnection createTable:@"DWTiming" withArguments:@"account text,daily text,enabled text,endTime text,f_account text,openTime text,periodName text,periodNo text,seq text,spaceTime text,timeCoder text,upTime text"];
    }
    
    NSString *userId = timingData.userId;
    NSString *userName = timingData.userName;
    NSString *diaryContent = timingData.diaryContent;
    NSString *mood = timingData.mood;
    NSString *time = timingData.time;
    NSString *location = timingData.location;
    BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into DWTiming values(?,?,?,?,?,?)",userId,userName,diaryContent,mood,time,location];
    if (insert) {
        NSLog(@"插入数据库成功");
    }
    [[dbConnection DB] close];
}

//queryall
-(void)saveDairyData:(LizzieDiaryModel *)dairyData
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    
    if ([dbConnection isTableOK:TABLE_NAME_DIARY]) {

            BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into DWTiming values(?,?,?,?,?,?,?,?,?,?,?,?)",dairyData.userId,dairyData.userName,dairyData.diaryContent,dairyData.mood,dairyData.time,dairyData.location];
            if (insert) {
                NSLog(@"新增成功");
            }
    }else{
        
        [dbConnection createTable:@"DWTiming" withArguments:@"account text,daily text,enabled text,endTime text,f_account text,openTime text,periodName text,periodNo text,seq text,spaceTime text,timeCoder text,upTime text"];
        
            BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into DWTiming values(?,?,?,?,?,?,?,?,?,?,?,?)",dairyData.userId,dairyData.userName,dairyData.diaryContent,dairyData.mood,dairyData.time,dairyData.location];
            if (insert) {
                NSLog(@"插入数据库成功");
            }
    }
    [[dbConnection DB] close];
}

-(int)getTimingObjectsNum:(NSString *)f_account1
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
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
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    FMResultSet *result = [[dbConnection DB] executeQuery:@"select * from DWTiming where f_account = ?",f_account1];
    while ([result next]) {
        LizzieDiaryModel  *dairyInfo = [[LizzieDiaryModel alloc]init];
        
        dairyInfo.userId = [result stringForColumn:@"userId"];
        dairyInfo.userName = [result stringForColumn:@"userName"];
        dairyInfo.diaryContent = [result stringForColumn:@"diaryContent"];
        dairyInfo.mood = [result stringForColumn:@"mood"];
        dairyInfo.time = [result stringForColumn:@"time"];
        dairyInfo.location = [result stringForColumn:@"location"];
        
        [userArray addObject:dairyInfo];
        
    }
    
    [[dbConnection DB] close];
    
    return userArray;
}

//删除定时器
-(void)deleteTimer:(NSString *)seqName
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
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
-(void)updateDairy:(NSString *)userId userName:(NSString *)userName dairyContent:(NSString *)dairyContent mood:(NSString *)mood time:(NSString *)time location:(NSString *)location
{
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
    
    BOOL  update =  [[dbConnection DB] executeUpdate:@"update DWTiming set userId = ? ,userName = ? ,dairyContent = ?,mood = ? ,time = ? ,location = ? where time = ?",userId,userName,dairyContent,mood,time,location,time];
    
    if (update) {
        NSLog(@"更新定时器成功");
    }
    [[dbConnection DB] close];
}


+(NSArray *)getTimingObjects
{
NSMutableArray *userArray = [[NSMutableArray alloc]initWithCapacity:1];

DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
[dbConnection readyDatabse];
if (![[dbConnection DB] open]) {
    NSLog(@"数据库没有打开");
}

FMResultSet *result = [[dbConnection DB] executeQuery:@"select * from DWTiming"];
while ([result next]) {
    
    LizzieDiaryModel  *dairyInfo = [[LizzieDiaryModel alloc]init];
    dairyInfo.userId = [result stringForColumn:@"account"];
    dairyInfo.userName = [result stringForColumn:@"daily"];
    dairyInfo.diaryContent = [result stringForColumn:@"enabled"];
    dairyInfo.mood = [result stringForColumn:@"endTime"];
    dairyInfo.time = [result stringForColumn:@"f_account"];
    dairyInfo.location = [result stringForColumn:@"openTime"];
    [userArray addObject:dairyInfo];
    
}

[[dbConnection DB] close];

return userArray;
}
@end
