//
//  DashCollectionViewFlowLayout.m
//  MoveDemo
//
//  Created by lulu on 16/8/15.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import "DashCollectionViewFlowLayout.h"


// 1X1 指标的大小
#define SizeOneDash CGSizeMake((Main_Screen_Width-3*KBianJu)/2.0, (KViewHeight-30*KHeight6scale - 4*KBianJu)/4.0)
// 2X1 指标的大小
#define SizeTwoDash CGSizeMake(Main_Screen_Width-2*KBianJu, (KViewHeight-30*KHeight6scale- 4*KBianJu)/4.0)
// 2X2 指标的大小
#define SizeThreeDash CGSizeMake(Main_Screen_Width-2*KBianJu, (KViewHeight-30*KHeight6scale- 2*KBianJu)/2.0)

@implementation DashCollectionViewFlowLayout


//懒加载数组
- (NSArray<UICollectionViewLayoutAttributes *> *)attributes
{
    if (_attributes == nil) {
        
        _attributes = [NSArray array];
    }
    return _attributes;
}
- (NSMutableArray *)DashModelArray
{
    if (_DashModelArray == nil) {
        _DashModelArray = [NSMutableArray array];
    }
    return _DashModelArray;
}
-(void)prepareLayout
{
    
    [super prepareLayout];
    
    
    _tempAtt = [NSMutableArray array];
    _viewDashArray = [NSMutableArray array];
    
    [self makeDashView];
    
}

// Dashview布局
- (void)makeDashView
{
    if (_DashModelArray.count != 0) {
        // 当前指标model对应的视图
        
        UIView * tempviewi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        // 当前指标model的前一个指标model对应的视图
        UIView * tempviewj = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        for (int i = 0; i < _DashModelArray.count; i++) {
            // model对应的视图
            _viewDash = [[UIView alloc] init];

            if (i != 0) {
                // 当前指标model的前一个指标model对应的视图
                tempviewj =  _viewDashArray[i - 1];
                
            }
            // 当前指标视图的位置大小
            CGRect  tempi = tempviewi.frame;
            // 前一个指标视图的位置大小
            CGRect  tempj = tempviewj.frame;
            
            // 当前指标model
            DashBoardModel * model = nil;
            // 前一个指标model
            DashBoardModel * modeltwo = nil;
            // i = 0第一个指标视图
            if (i == 0) {
            
                // 第一个指标视图的位置大小
                tempi.origin = CGPointMake(KBianJu, 0);
                
                model = _DashModelArray[i];
                
                if ((model.size_x == 1 )&& (model.size_y == 1) ) {
                    
                    tempi.size = SizeOneDash;
                    
                }else if((model.size_x == 2 )&& (model.size_y == 1) ){
                    
                    tempi.size = SizeTwoDash;
                    
                }else if((model.size_x == 2 )&& (model.size_y == 2) ){
                    
                    tempi.size = SizeThreeDash;
                    
                }
            
            }else{
                // 第二个及后面的指标视图的大小和位置
                model = _DashModelArray[i];

                if ((model.size_x == 1 )&& (model.size_y == 1)) {

                    tempi.size = SizeOneDash;

                    modeltwo = _DashModelArray[i-1];

                    if ((modeltwo.size_x == 1 )&& (modeltwo.size_y == 1)) {
                        
                        if (tempj.origin.x > (Main_Screen_Width-3*KBianJu)/2.0 && tempj.origin.x < Main_Screen_Width*2/3) {
                            
                            tempi.origin = CGPointMake(KBianJu, CGRectGetMaxY(tempj) + KBianJu );
                            
                        }else{
                            
                            tempi.origin = CGPointMake(KBianJu + CGRectGetMaxX(tempj), CGRectGetMinY(tempj));
                            
                        }
                    }else{

                        tempi.origin = CGPointMake(KBianJu, CGRectGetMaxY(tempj) + KBianJu);
                    }

                }else if((model.size_x == 2 )&& (model.size_y == 1)){
                    
                    tempi.size = SizeTwoDash;
                                        
                    tempi.origin = CGPointMake(KBianJu, CGRectGetMaxY(tempj) + KBianJu);
                    
                }else if((model.size_x == 2 )&& (model.size_y == 2) ){
                    
                    tempi.size = SizeThreeDash;
                    
                    tempi.origin = CGPointMake(KBianJu, CGRectGetMaxY(tempj) + KBianJu);
                    
                }
                
            }
            
            tempviewi.frame = tempi;
            
            _viewDash.frame = tempi;
            
            [_viewDashArray addObject:_viewDash];
            
            //创建布局属性 设置对应cell的frame
            UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            att.frame = tempi;
            
            [_tempAtt addObject:att];
            att = nil;
        }
    }
    
    self.attributes = _tempAtt;
    _tempAtt = nil;
    
}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return self.attributes;
}
- (CGSize)collectionViewContentSize
{
    
    UIView * view = _viewDashArray.lastObject;
    
    
    CGSize contentSize = CGSizeMake(Main_Screen_Width, CGRectGetMaxY(view.frame) + NavgationHeight +KBianJu);
    
    if (contentSize.height<=KViewHeight) {
        
        CGSize contentSize = CGSizeMake(Main_Screen_Width, Main_Screen_Height);
        return contentSize;
    }else{
        return contentSize;
    }
    
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.attributes[indexPath.row];
}

@end
