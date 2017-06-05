//
//  LMDairyViewController.h
//  milks_assistant
//  爱你一生一世，刘磊璐
//  Create by Jason Huang on 17/4/4.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMBaseViewController.h"
#import "LizzieDairyDataInfo.h"

@interface LMDairyListViewController : LMBaseViewController

@end


@interface lizzieDairyCell : UITableViewCell

@property(nonatomic,strong)UIImageView *note_icon;
@property(nonatomic,strong)UILabel *dairyContent;
@property(nonatomic,strong)UILabel *dairyDate;
@property(nonatomic,strong)UILabel *dairyMood;
@property(nonatomic,strong)LizzieDiaryModel *info;

@end
