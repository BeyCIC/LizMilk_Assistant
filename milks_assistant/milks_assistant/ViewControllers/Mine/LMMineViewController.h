//
//  LMMineViewController.h
//  milks_assistant
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 17/3/31.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMBaseViewController.h"

@interface LMMineViewController : LMBaseViewController

@end


@interface LuHeaderCell : UITableViewCell

@property(nonatomic,strong)UIButton *headerIcon;
@property(nonatomic,strong)UITextField *name;

- (void)setUserHeader:(NSString*)header;

- (void)setUserName:(NSString*)name;

@end
