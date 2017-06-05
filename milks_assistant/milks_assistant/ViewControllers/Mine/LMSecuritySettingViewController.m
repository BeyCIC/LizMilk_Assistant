//
//  LMSecuritySettingViewController.m
//  milks_assistant
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 2017/5/2.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMSecuritySettingViewController.h"
#import "KeychainData.h"
#import "SetpasswordViewController.h"
#import "LMTouchIDManager.h"

@interface LMSecuritySettingViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_mainTable;
    
}

@end

@implementation LMSecuritySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_mainTable];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.title = @"Security Setting";
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
        cell.textLabel.text = @"Gesture Password";
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
        cell.textLabel.text = @"Touch ID";
        UISwitch *touchSwitch = [[UISwitch alloc] init];
        if ([[LMTouchIDManager sharedInstance] currentUserOpenTouchID] && [[LMTouchIDManager sharedInstance] isTouchIdAvailable]) {
            [touchSwitch setOn:YES];
        }
         touchSwitch.frame = CGRectMake(SCREEN_WIDTH - touchSwitch.frame.size.width - 30, (44-touchSwitch.frame.size.height)/2, touchSwitch.frame.size.width, touchSwitch.frame.size.height);
        [touchSwitch addTarget:self action:@selector(touchSwitch:) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    if (![[LMTouchIDManager sharedInstance] isTouchIdAvailable]) {
        [self showAlertWithTitle:@"Prompt" msg:@"您的手机未开启touchID验证" ok:@"Sure" cancel:nil];
    } else if([[LMTouchIDManager sharedInstance] isTouchIdAvailable] && sender.isOn)
    {
//         __weak typeof(self) wself = self;
        [[LMTouchIDManager sharedInstance] evaluatePolicy: @"通过Home键验证已有手机指纹" fallbackTitle:@"" SuccesResult:^{
            [[LMTouchIDManager sharedInstance] saveHadSetTouchIDUsersString:kHasSetTouchIDValue];
            [self showAlertWithTitle:@"Prompt" msg:@"Fingerprint unlocking is on" ok:@"Sure" cancel:nil];
        } FailureResult:^(LAError result){
            [sender setOn:NO];
            switch (result) {
                case LAErrorAuthenticationFailed: {
                    // 认证失败 showflash
                    [self showAlertWithTitle:@"Prompt" msg:@"Authentication failed" ok:@"Sure" cancel:nil];
                    break;
                }
                case LAErrorTouchIDLockout: {
                    // 认证失败 showflash
                    [self showAlertWithTitle:@"Prompt" msg:@"Authentication failed" ok:@"Sure" cancel:nil];
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
