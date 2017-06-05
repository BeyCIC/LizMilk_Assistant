//
//  FMDatabasePool.h
//  fmdb
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 6/22/11.
//  Copyright 2011 JasonHuang All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@class FMDatabase;

@interface FMDatabaseQueue : NSObject {
    NSString            *_path;
    dispatch_queue_t    _queue;
    FMDatabase          *_db;
}

@property (retain) NSString *path;

+ (id)databaseQueueWithPath:(NSString*)aPath;
- (id)initWithPath:(NSString*)aPath;
- (void)close;

- (void)inDatabase:(void (^)(FMDatabase *db))block;

- (void)inTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;
- (void)inDeferredTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;

#if SQLITE_VERSION_NUMBER >= 3007000
// NOTE: you can not nest these, since calling it will pull another database out of the pool and you'll get a deadlock.
// If you need to nest, use FMDatabase's startSavePointWithName:error: instead.
- (NSError*)inSavePoint:(void (^)(FMDatabase *db, BOOL *rollback))block;
#endif

@end

