//
//  HYSTabBarViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 2017/5/16.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "HYSTabBarViewController.h"

@interface HYSTabBarViewController ()

@end

@implementation HYSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.tabBar.frame;
    
    frame.size.height = 60;
    
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    
    self.tabBar.frame = frame;
    
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
