//
//  LMReadDairyViewController.m
//  milks_assistant
//
//  Created by Jason Huang on 17/4/4.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMReadDairyViewController.h"

@interface LMReadDairyViewController () {
    UILabel *_dairyContent;
    
    NSString *_contentStr;
}

@end

@implementation LMReadDairyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView {
    
    _dairyContent = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH - 30, SCREEN_HEIGHT)];
    _dairyContent.textAlignment = NSTextAlignmentCenter;
    _dairyContent.textColor = [UIColor purpleColor];
    _dairyContent.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_dairyContent];
    
    _contentStr = @"今天做了什么？";
    
    _dairyContent.text = _contentStr;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
