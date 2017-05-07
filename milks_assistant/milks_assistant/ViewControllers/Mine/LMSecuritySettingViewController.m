//
//  LMSecuritySettingViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 2017/5/2.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMSecuritySettingViewController.h"
#import "KeychainData.h"
#import "SetpasswordViewController.h"
#import "UPXTouchIDManager.h"

@interface LMSecuritySettingViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_mainTable;
    
}

@end

@implementation LMSecuritySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_mainTable];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_mainTable) {
        [_mainTable reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"手势密码";
        UISwitch *gesSwitch = [[UISwitch alloc] init];
        gesSwitch.frame = CGRectMake(SCREEN_WIDTH - gesSwitch.frame.size.width - 30, (44-gesSwitch.frame.size.height)/2, gesSwitch.frame.size.width, gesSwitch.frame.size.height);
        [gesSwitch addTarget:self action:@selector(gesSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
        BOOL isSave = [KeychainData isSave]; //是否有保存
        if (isSave) {
            [gesSwitch setOn:YES];
        } else {
            [gesSwitch setOn:NO];
        }
        [cell addSubview:gesSwitch];
    } else {
        cell.textLabel.text = @"指纹解锁";
        UISwitch *touchSwitch = [[UISwitch alloc] init];
         touchSwitch.frame = CGRectMake(SCREEN_WIDTH - touchSwitch.frame.size.width - 30, (44-touchSwitch.frame.size.height)/2, touchSwitch.frame.size.width, touchSwitch.frame.size.height);
        [cell addSubview:touchSwitch];
    }
    
    return cell;
}

- (void)gesSwitchAction:(UISwitch*)sender{
    
    if (sender.isOn) {
        
        [self forgotPassword];
        SetpasswordViewController *setpass = [[SetpasswordViewController alloc] init];
        setpass.string = @"重置密码";
        [self presentViewController:setpass animated:YES completion:nil];
    } else {
        [self forgotPassword];
    }
}

- (void)touchSwitch:(UISwitch*)sender {
    
    if (![[UPXTouchIDManager sharedInstance] isTouchIdAvailable] && sender.isOn) {
        [self showAlertWithTitle:@"提示" msg:@"您的手机未开启touchID验证" ok:@"确定" cancel:nil];
    } else {
         __weak typeof(self) wself = self;
        [[UPXTouchIDManager sharedInstance] evaluatePolicy: @"通过Home键验证已有手机指纹" fallbackTitle:@"" SuccesResult:^{
            [[UPXTouchIDManager sharedInstance] saveHadSetTouchIDUsersString:kHasSetTouchIDValue];
//            [wself showFlashInfo:@"指纹解锁已开启" withImage:[]];
            [self showAlertWithTitle:@"提示" msg:@"指纹解锁已开启" ok:@"确定" cancel:nil];
        } FailureResult:^(LAError result){
            [sender setOn:NO];
            switch (result) {
                case LAErrorAuthenticationFailed: {
                    // 认证失败 showflash
//                    [wself showFlashInfo:UP_STR(@"String_TouchID_Failed_Title")];
                    [self showAlertWithTitle:@"提示" msg:@"认证失败" ok:@"确定" cancel:nil];
                    break;
                }
                case LAErrorTouchIDLockout: {
                    // 认证失败 showflash
                    [self showAlertWithTitle:@"提示" msg:@"认证失败" ok:@"确定" cancel:nil];
//                    [wself showFlashInfo:UP_STR(@"String_TouchID_Failed_Title")];
                    break;
                }
                default: {
                    break;
                }
            }
        }];
    }
}

- (void)forgotPassword
{
    [KeychainData forgotPsw];
//    [self hudAction:@"忘记密码"];
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
