//
//  LMDairyViewController.h
//  milks_assistant
//
//  Created by Jason Huang on 17/4/4.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMBaseViewController.h"
#import "LizzieDairyDataInfo.h"

@interface LMDairyListViewController : LMBaseViewController

@end


@interface lizzieDairyCell : UITableViewCell

@property(nonatomic,strong)UILabel *dairyContent;
@property(nonatomic,strong)UILabel *dairyDate;
@property(nonatomic,strong)UILabel *dairyMood;
@property(nonatomic,strong)LizzieDiaryModel *info;

@end
