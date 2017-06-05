//
//  DWTimingDataInfo.m
//    
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 13-12-19.
//  Copyright (c) 2013年 JasonHuang. All rights reserved.
//

#import "LizzieDairyDataInfo.h"
 
@implementation LizzieDairyDataInfo


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

//@property (nonatomic, copy) NSString<Optional>* userId;
//@property (nonatomic, copy) NSString<Optional>* userName;
//@property (nonatomic, copy) NSString<Optional>* diaryContent;
//@property (nonatomic, copy) NSString<Optional>* mood;
//@property (nonatomic, copy) NSString<Optional>* time;
//@property (nonatomic, copy) NSString<Optional>* location;

//添加定时器
-(void)addDiary:(LizzieDiaryModel *)timingData
{
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    if (![dbConnection isTableOK:TABLE_NAME_DIARY]) {
        [dbConnection createTable:@"Lizziediary" withArguments:@"userId text,userName text,diaryContent text,mood text,time text,location text"];
    }
    
    NSString *userId = timingData.userId;
    NSString *userName = timingData.userName;
    NSString *diaryContent = timingData.diaryContent;
    NSString *mood = timingData.mood;
    NSString *time = timingData.time;
    NSString *location = timingData.location;
    BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into Lizziediary values(?,?,?,?,?,?)",userId,userName,diaryContent,mood,time,location];
    if (insert) {
        NSLog(@"插入数据库成功");
    } else {
        NSLog(@"插入数据库失败");
    }
    [[dbConnection DB] close];
}

//添加定时器
-(void)updateDiary:(LizzieDiaryModel *)timingData
{
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    if (![dbConnection isTableOK:TABLE_NAME_DIARY]) {
        [dbConnection createTable:@"Lizziediary" withArguments:@"userId text,userName text,diaryContent text,mood text,time text,location text"];
    }
    
    NSString *userId = timingData.userId;
    NSString *userName = timingData.userName;
    NSString *diaryContent = timingData.diaryContent;
    NSString *mood = timingData.mood;
    NSString *time = timingData.time;
    NSString *location = timingData.location;
    
    BOOL  update =  [[dbConnection DB] executeUpdate:@"update Lizziediary set userName = ? ,diaryContent = ?,mood = ?,location = ?where time = ?",userName,diaryContent,mood,location,time];
    if (update) {
        NSLog(@"更新数据库成功");
    } else {
        NSLog(@"更新数据库失败");
    }
    [[dbConnection DB] close];
    
    
//    NSString *did = timingData.Did;
//    NSString *title = timingData.title;
//    NSString *color = timingData.color;
//    NSString *size_x = timingData.size_x;
//    NSString *size_y = timingData.size_y;
//    //    NSString *location = timingData.location;
//    BOOL  update =  [[dbConnection DB] executeUpdate:@"update DashBoard set title = ? ,color = ? ,size_x = ?,size_y = ? where Did = ?",title,color,size_x,size_y,did];
//    if (update) {
//        NSLog(@"更新数据库成功");
//    } else {
//        NSLog(@"更新数据库失败");
//    }
    [[dbConnection DB] close];
}



//queryall
-(void)saveDiary:(LizzieDiaryModel *)dairyData
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    
    if ([dbConnection isTableOK:TABLE_NAME_DIARY]) {

            BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into Lizziediary values(?,?,?,?,?,?)",dairyData.userId,dairyData.userName,dairyData.diaryContent,dairyData.mood,dairyData.time,dairyData.location];
            if (insert) {
                NSLog(@"新增成功");
            }
    }else{
        
        [dbConnection createTable:@"Lizziediary" withArguments:@"userId text,userName text,diaryContent text,mood text,time text,location text"];
        
            BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into Lizziediary values(?,?,?,?,?,?)",dairyData.userId,dairyData.userName,dairyData.diaryContent,dairyData.mood,dairyData.time,dairyData.location];
            if (insert) {
                NSLog(@"插入数据库成功");
            } else {
                NSLog(@"插入数据库失败");
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
    
    FMResultSet *result = [[dbConnection DB] executeQuery:@"select count(*) from Lizziediary where f_account = ? and spaceTime<>''",f_account1];
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
    
    FMResultSet *result = [[dbConnection DB] executeQuery:@"select * from Lizziediary where f_account = ?",f_account1];
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
    
    BOOL  delete=  [[dbConnection DB] executeUpdate:@"delete from Lizziediary where seq = ?",seqName];
    
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
    
    BOOL  update =  [[dbConnection DB] executeUpdate:@"update Lizziediary set userId = ? ,userName = ? ,dairyContent = ?,mood = ? ,time = ? ,location = ? where time = ?",userId,userName,dairyContent,mood,time,location,time];
    
    if (update) {
        NSLog(@"更新定时器成功");
    }
    [[dbConnection DB] close];
}


+(NSArray *)getDairyObjects;
{

    NSMutableArray *userArray = [[NSMutableArray alloc]initWithCapacity:1];
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    FMResultSet *result = [[dbConnection DB] executeQuery:@"select * from Lizziediary"];
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
@end
