//
//  DBConnection.m
//    
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 13-12-2.
//  Copyright (c) 2013年 JasonHuang. All rights reserved.
//

#import "DBConnection.h"

@implementation DBConnection

@synthesize DB;
@synthesize DBName;


- (id)initWithDBName:(NSString *)dbName
{
    
    self = [super init];
    
    if(nil != self)
    {
        DBName = [self getPath:dbName];
        //self.DB = [FMDatabase databaseWithPath:dbName];
        //WILog(@"DBName: %@", DBName);
    }
    
    return self;
}

//关闭连接
- (void)close
{
    [DB close];
}

// 数据库存储路径(内部使用)
- (NSString *)getPath:(NSString *)dbName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:dbName];
}


// 打开数据库
- (void)readyDatabse
{
    //BOOL success;
    //NSError *error;
    
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    //success = [fileManager fileExistsAtPath:self.DBName];
    
    /*
    if ([DB tableExists:<#(NSString *)#>])
        return;
    */
    
    //DB = [FMDatabase databaseWithPath:DBName];
    DB = [[FMDatabase alloc] initWithPath:DBName];
    
    if (![DB open])
    {
        [DB close];
        NSAssert1(0, @"Failed to open database file with message '%@'.", [DB lastErrorMessage]);
    }
    
    // kind of experimentalish.
    [DB setShouldCacheStatements:YES];
}

#pragma mark 删除数据库
// 删除数据库
- (void)deleteDatabse
{
    BOOL success;
    NSError *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // delete the old db.
    if ([fileManager fileExistsAtPath:DBName])
    {
        [DB close];
        success = [fileManager removeItemAtPath:DBName error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to delete old database file with message '%@'.", [error localizedDescription]);
        }
    }
}


/*
FMResultSet *rs = [self.database executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
while ([rs next])
{
    // just print out what we've got in a number of formats.
    NSInteger count = [rs intForColumn:@"count"];
    NSLog(@"isTableOK %d", count);
    
    if (0 == count)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

return NO;
*/

// 判断是否存在表
- (BOOL) isTableOK:(NSString *)tableName
{
    FMResultSet *rs = [DB executeQuery:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = ?", tableName];
    NSInteger count = 0;
    BOOL res = NO;
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        count = [rs intForColumn:@"count"];
        if (count >0)
        {
            res = YES;
        }
    }
    NSLog(@"DBConnection isTableOK %@ %d",tableName,count);
    return res;
}

// 获得表的数据条数
- (BOOL) getTableItemCount:(NSString *)tableName
{
    NSString *sqlstr = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM %@", tableName];
    FMResultSet *rs = [DB executeQuery:sqlstr];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
              NSLog(@"TableItemCount %d", count);
        
        return count;
    }
    
    return 0;
}

// 创建表
- (BOOL) createTable:(NSString *)tableName withArguments:(NSString *)arguments
{
    NSString *sqlstr = [NSString stringWithFormat:@"CREATE TABLE %@ (%@)", tableName, arguments];
    if (![DB executeUpdate:sqlstr])
        //if ([DB executeUpdate:@"create table user (name text, pass text)"] == nil)
    {
        NSLog(@"Create db error");
        return NO;
    }
    
    return YES;
}

// 删除表
- (BOOL) deleteTable:(NSString *)tableName
{
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", tableName];
    if (![DB executeUpdate:sqlstr])
    {
        NSLog(@"DBConnetion deleteTable table:%@ error",tableName);
        return NO;
    }
    
    return YES;
}

// 清除表
- (BOOL) eraseTable:(NSString *)tableName
{
    NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
    if (![DB executeUpdate:sqlstr])
    {
        NSLog(@"Erase table error");
        return NO;
    }
    
    return YES;
}


// 插入数据
/*
- (BOOL)insertTable:(NSString*)sql
{

  //  va_list args;
  //  va_start(args, sql);
    
 //   BOOL result = [DB executeUpdate:sql error:nil withArgumentsInArray:nil orVAList:args];
   // BOOL result = [DB executeupda];
    
   // va_end(args);
    //return result;
 
}

// 修改数据
- (BOOL)updateTable:(NSString*)sql, ...
{
    va_list args;
    va_start(args, sql);
    
    BOOL result = [DB executeUpdate:sql error:nil withArgumentsInArray:nil orVAList:args];
    
    va_end(args);
    return result;
}

*/
// 暂时无用
#pragma mark 获得单一数据

// 整型
- (NSInteger)getDb_Integerdata:(NSString *)tableName withFieldName:(NSString *)fieldName
{
    NSInteger result = NO;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", fieldName, tableName];
    FMResultSet *rs = [DB executeQuery:sql];
    if ([rs next])
        result = [rs intForColumnIndex:0];
    [rs close];
    
    return result;
}

// 布尔型
- (BOOL)getDb_Booldata:(NSString *)tableName withFieldName:(NSString *)fieldName
{
    BOOL result;
    
    result = [self getDb_Integerdata:tableName withFieldName:fieldName];
    
    return result;
}

// 字符串型
- (NSString *)getDb_Stringdata:(NSString *)tableName withFieldName:(NSString *)fieldName
{
    NSString *result = NO;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", fieldName, tableName];
    FMResultSet *rs = [DB executeQuery:sql];
    if ([rs next])
        result = [rs stringForColumnIndex:0];
    [rs close];
    
    return result;
}

// 二进制数据型
- (NSData *)getDb_Bolbdata:(NSString *)tableName withFieldName:(NSString *)fieldName
{
    NSData *result = NO;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", fieldName, tableName];
    FMResultSet *rs = [DB executeQuery:sql];
    if ([rs next])
        result = [rs dataForColumnIndex:0];
    [rs close];
    
    return result;
}

//打开表
//打开表DWGPS
-(DBConnection*)openTable:(NSString*)tableName
{
    DBConnection *dbConnection = [self initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    if (![dbConnection isTableOK:tableName]) {
        NSLog(@"数据库表:%@ 打开失败",tableName);
        [[dbConnection DB] close];
        dbConnection = nil;
    }
    return dbConnection;
}
@end
