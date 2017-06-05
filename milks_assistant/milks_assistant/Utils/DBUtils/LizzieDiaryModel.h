//
//  UPWAppInfoModel.h
//  wallet
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 14/11/4.
//  Copyright (c) 2014年 JasonHuang. All rights reserved.
//

#import "JSONModel.h"

@interface LizzieDiaryModel : JSONModel

@property (nonatomic, copy) NSString<Optional>* userId;
@property (nonatomic, copy) NSString<Optional>* userName;
@property (nonatomic, copy) NSString<Optional>* diaryContent;
@property (nonatomic, copy) NSString<Optional>* mood;
@property (nonatomic, copy) NSString<Optional>* time;
@property (nonatomic, copy) NSString<Optional>* location;

@end
