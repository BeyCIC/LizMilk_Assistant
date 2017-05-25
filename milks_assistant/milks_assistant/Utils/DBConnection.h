//
//  DBConnection.h
//  DearWhere
//
//  Create by lgp on 13-12-2.
//  Copyright (c) 2013年 lgp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"


@interface DBConnection : NSObject

{
    FMDatabase *DB;
    
}
@property (strong,nonatomic)FMDatabase *DB;
@property (strong,nonatomic)NSString *DBName;

//+ (id)modelWithDBName:(NSString *)dbName;
- (id)initWithDBName:(NSString *)dbName;

//关闭连接
- (void)close;
// 删除数据库
- (void)deleteDatabse;

// 数据库存储路径
- (NSString *)getPath:(NSString *)dbName;
// 打开数据库
- (void)readyDatabse;

// 判断是否存在表
- (BOOL) isTableOK:(NSString *)tableName;
// 获得表的数据条数
- (BOOL) getTableItemCount:(NSString *)tableName;
// 创建表
- (BOOL) createTable:(NSString *)tableName withArguments:(NSString *)arguments;
// 删除表-彻底删除表
- (BOOL) deleteTable:(NSString *)tableName;
// 清除表-清数据
- (BOOL) eraseTable:(NSString *)tableName;
// 插入数据
//- (BOOL)insertTable:(NSString*)sql;
//- (BOOL)insertTable:(NSString*)sql, ...;
//// 修改数据
//- (BOOL)updateTable:(NSString*)sql, ...;


// 整型
- (NSInteger)getDb_Integerdata:(NSString *)tableName withFieldName:(NSString *)fieldName;
// 布尔型
- (BOOL)getDb_Booldata:(NSString *)tableName withFieldName:(NSString *)fieldName;
// 字符串型
- (NSString *)getDb_Stringdata:(NSString *)tableName withFieldName:(NSString *)fieldName;
// 二进制数据型
- (NSData *)getDb_Bolbdata:(NSString *)tableName withFieldName:(NSString *)fieldName;
//打开表
-(DBConnection*)openTable:(NSString*)tableName;

@end
