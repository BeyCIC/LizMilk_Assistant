//
//  LWFilterCollectionView.m
//  PhotoDIY
//
//  Created by luowei on 16/7/5.
//  Copyright © 2016年 wodedata. All rights reserved.
//

#import "LWFilterCollectionView.h"
#import "LWDataManager.h"
#import "LWContentView.h"
#import "Categorys.h"
#import "LWFilterImageView.h"

@implementation LWFilterCollectionView{
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

        [self awakeFromNib];
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.dataSource = self;
    self.delegate = self;
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    self.topLine.hidden = hidden;
}

//重新加载Filters
-(void)reloadFilters{
    self.filterDict = [[LWDataManager sharedInstance] filters];
    self.filterImageNameDict = [[LWDataManager sharedInstance] filterImageName];
    [self reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.filterDict && self.filterDict.count > 0){
        return self.filterDict.allKeys.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWFilterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWFilterCollectionCell" forIndexPath:indexPath];
//    cell.titleLbl.text = self.filterDict.allKeys[indexPath.item];
    cell.titleLbl.text = self.filterImageNameDict.allKeys[indexPath.item];
    if ([cell.titleLbl.text isEqualToString:@"Gamma"]) {
        cell.titleLbl.text = @"伽玛射线";
    }
    NSString *imageName = self.filterImageNameDict.allKeys[indexPath.item];
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    LWFilterCollectionCell *cel = (LWFilterCollectionCell *)cell;
    if(self.selectedIndexPath != nil && self.selectedIndexPath.item == indexPath.item){
        cel.selectIcon.hidden = NO;
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }else{
        cel.selectIcon.hidden = YES;
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LWFilterCollectionCell *cell = (LWFilterCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    cell.selected = YES;
    cell.selectIcon.hidden = NO;
    self.selectedIndexPath = indexPath;

    NSString *nowkey = self.filterDict.allKeys[indexPath.item];
    LWContentView *drawView = [self superViewWithClass:[LWContentView class]];
//    NSString *key = cell.titleLbl.text;
    [drawView.filterView renderWithFilterKey:nowkey];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    LWFilterCollectionCell *cell = (LWFilterCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    cell.selected = NO;
    cell.selectIcon.hidden = YES;
}



@end


@implementation LWFilterCollectionCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 80, 18)];
        _titleLbl.font = [UIFont systemFontOfSize:14];
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLbl.tag = 102;
        _titleLbl.contentMode = UIViewContentModeLeft;
        [self addSubview:_titleLbl];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 80, 98)];
        _imageView.tag = 101;
        [_imageView setImage:[UIImage imageNamed:@"虚化背影"]];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.opaque = YES;
        _imageView.clipsToBounds = YES;
        
        _selectIcon = [[UIImageView alloc] initWithFrame:CGRectMake(30, 50, 20, 20)];
        [_selectIcon setImage:[UIImage imageNamed:@"iconSelect"]];
        [_selectIcon setHighlightedImage:[UIImage imageNamed:@"iconSelect"]];
        [_selectIcon setContentMode:UIViewContentModeScaleToFill];
        _selectIcon.opaque = YES;
        _selectIcon.hidden = YES;
        
        [self addSubview:_imageView];
        
        [self addSubview:_selectIcon];
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView = (UIImageView *)[self viewWithTag:101];
    self.titleLbl = (UILabel *)[self viewWithTag:102];
}


@end
