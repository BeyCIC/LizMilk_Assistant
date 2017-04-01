//
//  UPWAppInfoModel.h
//  wallet
//
//  Created by qcao on 14/11/4.
//  Copyright (c) 2014年 China Unionpay Co.,Ltd. All rights reserved.
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
