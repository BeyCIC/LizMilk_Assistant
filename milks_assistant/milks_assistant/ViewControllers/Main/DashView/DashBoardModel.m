//
//  DashBoardModel.m
//  MoveDemo
//
//  Created by lulu on 16/8/1.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import "DashBoardModel.h"

@implementation DashBoardModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.Did = value;
    }
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_Did forKey:@"Did"];
    [aCoder encodeObject:_color forKey:@"color"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeInteger:_size_x forKey:@"size_x"];
    [aCoder encodeInteger:_size_y forKey:@"size_y"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _Did = [aDecoder decodeObjectForKey:@"Did"];
        _color = [aDecoder decodeObjectForKey:@"color"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _size_x = [aDecoder decodeIntegerForKey:@"size_x"];
        _size_y = [aDecoder decodeIntegerForKey:@"size_y"];
    
    }

    return self;
}
@end
