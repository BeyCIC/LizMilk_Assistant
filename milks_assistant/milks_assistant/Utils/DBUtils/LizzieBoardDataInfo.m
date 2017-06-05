//
//  DWTimingDataInfo.m
//    
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 13-12-19.
//  Copyright (c) 2013年 JasonHuang. All rights reserved.
//

#import "LizzieBoardDataInfo.h"
 
@implementation LizzieBoardDataInfo


//更新定时器－queryall
-(void)updateTimingALL:(DashBoardModel*)data
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
    if ([dbConnection isTableOK:TABLE_NAME_DIARY]) {

        BOOL  update =  [[dbConnection DB] executeUpdate:@"update DashBoard set account = ?,userId = ?,userName = ?,diaryContent = ?,mood = ?,date = ?,location = ?",data.Did,data.Did,data.Did,data.Did,data.Did,data.Did];
        if (update) {
            NSLog(@"insert dairy success");
        }
    }
    [[dbConnection DB] close];
}
    
//删除定时器－queryall
-(void)deleteTimingAll:(DashBoardModel*)data
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
        return;
    }
    if ([dbConnection isTableOK:TABLE_NAME_DIARY]) {
        
            NSString *dairyDate = data.Did;
            BOOL  delete=  [[dbConnection DB] executeUpdate:@"delete from DashBoard where date = ?",dairyDate];
            
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

//@property (nonatomic,copy) NSString * Did;
//
//@property (nonatomic,copy) NSString * title;
//
//@property (nonatomic,copy) NSString * color;
//@property (nonatomic,assign) NSInteger size_x;
//
//@property (nonatomic,assign) NSInteger  size_y;
//添加定时器
-(void)addDiary:(DashBoardModel *)timingData
{
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    if (![dbConnection isTableOK:TABLE_NAME_DIARY]) {
        [dbConnection createTable:@"DashBoard" withArguments:@"Did text,title text,color text,size_x text,size_y text"];
    }
    
    NSString *userId = timingData.Did;
    NSString *userName = timingData.title;
    NSString *diaryContent = timingData.color;
    NSString *mood = timingData.size_x;
    NSString *time = timingData.size_y;
//    NSString *location = timingData.location;
    BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into DashBoard values(?,?,?,?,?)",userId,userName,diaryContent,mood,time];
    if (insert) {
        NSLog(@"插入数据库成功");
    } else {
        NSLog(@"插入数据库失败");
    }
    [[dbConnection DB] close];
}

//添加定时器
-(void)updateDashBoard:(DashBoardModel *)timingData
{
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    if (![dbConnection isTableOK:TABLE_NAME_DIARY]) {
        [dbConnection createTable:@"DashBoard" withArguments:@"Did text,title text,color text,size_x text,size_y text"];
    }
    
    NSString *did = timingData.Did;
    NSString *title = timingData.title;
    NSString *color = timingData.color;
    NSString *size_x = timingData.size_x;
    NSString *size_y = timingData.size_y;
    //    NSString *location = timingData.location;
    BOOL  update =  [[dbConnection DB] executeUpdate:@"update DashBoard set title = ? ,color = ? ,size_x = ?,size_y = ? where Did = ?",title,color,size_x,size_y,did];
    if (update) {
        NSLog(@"更新数据库成功");
    } else {
        NSLog(@"更新数据库失败");
    }
    [[dbConnection DB] close];
}


//queryall
-(void)saveDiary:(DashBoardModel *)dairyData
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    
    
    if ([dbConnection isTableOK:TABLE_NAME_DIARY]) {

            BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into DashBoard values(?,?,?,?,?)",dairyData.Did,dairyData.title,dairyData.color,dairyData.size_x,dairyData.size_y];
            if (insert) {
                NSLog(@"新增成功");
            }
    }else{
        
        [dbConnection createTable:@"DashBoard" withArguments:@"userId text,userName text,diaryContent text,mood text,time text,location text"];
        
            BOOL  insert =  [[dbConnection DB] executeUpdate:@"insert into DashBoard values(?,?,?,?,?,?)",dairyData.Did,dairyData.title,dairyData.color,dairyData.size_x,dairyData.size_y];
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
    
    FMResultSet *result = [[dbConnection DB] executeQuery:@"select count(*) from DashBoard where f_account = ? and spaceTime<>''",f_account1];
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
    
    FMResultSet *result = [[dbConnection DB] executeQuery:@"select * from DashBoard where f_account = ?",f_account1];
    while ([result next]) {
        DashBoardModel  *dairyInfo = [[DashBoardModel alloc]init];
        
        dairyInfo.Did = [result stringForColumn:@"Did"];
        dairyInfo.title = [result stringForColumn:@"title"];
        dairyInfo.color = [result stringForColumn:@"color"];
        dairyInfo.size_x = [result stringForColumn:@"size_x"];
        dairyInfo.size_y = [result stringForColumn:@"size_y"];
        
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
    
    BOOL  delete=  [[dbConnection DB] executeUpdate:@"delete from DashBoard where seq = ?",seqName];
    
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
    
    BOOL  update =  [[dbConnection DB] executeUpdate:@"update DashBoard set userId = ? ,userName = ? ,dairyContent = ?,mood = ? ,time = ? ,location = ? where time = ?",userId,userName,dairyContent,mood,time,location,time];
    
    if (update) {
        NSLog(@"更新定时器成功");
    }
    [[dbConnection DB] close];
}


+(NSArray *)getBoardObjects;
{

    NSMutableArray *userArray = [[NSMutableArray alloc]initWithCapacity:1];
    
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    FMResultSet *result = [[dbConnection DB] executeQuery:@"select * from DashBoard"];
    while ([result next]) {
        
        DashBoardModel  *dairyInfo = [[DashBoardModel alloc]init];
        dairyInfo.Did = [result stringForColumn:@"Did"];
        dairyInfo.title = [result stringForColumn:@"title"];
        dairyInfo.color = [result stringForColumn:@"color"];
        dairyInfo.size_x = [result stringForColumn:@"size_x"];
        dairyInfo.size_y = [result stringForColumn:@"size_y"];
        [userArray addObject:dairyInfo];
        
        
    }
    [[dbConnection DB] close];
    return userArray;
}
@end
