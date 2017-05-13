//
//  LMReadDairyViewController.m
//  milks_assistant
//
//  Created by Jason Huang on 17/4/4.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMReadDairyViewController.h"
#import "LMModDairyViewController.h"

@interface LMReadDairyViewController ()<modefinishedDelegate> {
    UILabel *_dairyContent;
    
    NSString *_contentStr;
}

@end

@implementation LMReadDairyViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *phoneButton = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(modDairy)];
    self.navigationItem.rightBarButtonItem = phoneButton;
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)modDairy {
    LMModDairyViewController *nextCtl = [[LMModDairyViewController alloc] init];
    nextCtl.dataInfo = self.dairyInfo;
    nextCtl.delegate = self;
    [self.navigationController pushViewController:nextCtl animated:YES];
}

- (void)modeFinished:(LizzieDiaryModel *)info {
    self.dairyInfo = info;
    _dairyContent.text = info.diaryContent;
    _dairyContent.numberOfLines = 0;
    _dairyContent.lineBreakMode = NSLineBreakByCharWrapping;
}

- (void)initView {
    
    _dairyContent = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, SCREEN_HEIGHT-80)];
    _dairyContent.textAlignment = NSTextAlignmentLeft;
    _dairyContent.textColor = [UIColor purpleColor];
    _dairyContent.numberOfLines = 0;
    _dairyContent.lineBreakMode = NSLineBreakByCharWrapping;
    _dairyContent.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_dairyContent];
    
    _contentStr = _dairyInfo.diaryContent;
    _dairyContent.text = _contentStr;
    CGRect rect = [_dairyContent.text boundingRectWithSize:_dairyContent.frame.size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:_dairyContent.font,NSFontAttributeName, nil] context:nil];
    _dairyContent.frame = CGRectMake(15,0, SCREEN_WIDTH - 30, rect.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
