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
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.title = @"Lizzie Liu";
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView {
    self.view.frame = CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT+20)];
    backgroundView.image = [UIImage imageNamed:@"seaSkyAndYou"];
    
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, (SCREEN_WIDTH - 100), 200)];
    [backgroundView addSubview:contentLab];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 10; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 2.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.5 alpha:1], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    NSString *heartSay =  @"“对我来讲，你永远都不是一个简洁的选项，而是一个麻烦但生动的人。他们忙着嘉奖你的乖巧，许诺一个更敞亮的未来给你。这些我都没有。但我宽纵你成为自己。”";
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:heartSay attributes:dic];
    contentLab.attributedText = attributeStr;

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
