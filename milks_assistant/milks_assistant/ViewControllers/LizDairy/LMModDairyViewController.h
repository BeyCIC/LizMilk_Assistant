//
//  LMAddDairyViewController.h
//  milks_assistant
//
//  Create by Jason Huang on 17/4/4.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMBaseViewController.h"
#import "LizzieDiaryModel.h"

@protocol modefinishedDelegate <NSObject>

- (void)modeFinished:(LizzieDiaryModel*)info;

@end

@interface LMModDairyViewController : LMBaseViewController
@property(nonatomic,strong)LizzieDiaryModel *dataInfo;
@property(nonatomic,weak)id<modefinishedDelegate>delegate;
@end
