//
//  LMHYSLizzieHelpViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 2017/5/17.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMHYSLizzieHelpViewController.h"

@interface LMHYSLizzieHelpViewController ()

@end

@implementation LMHYSLizzieHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView {
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backgroundView.image = [UIImage imageNamed:@""];
    
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [backgroundView addSubview:contentLab];
    contentLab.text = @"";
    contentLab.textColor = [UIColor blackColor];
    contentLab.textAlignment = NSTextAlignmentLeft;
    contentLab.numberOfLines =  0;
    [self.view addSubview:backgroundView];
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
