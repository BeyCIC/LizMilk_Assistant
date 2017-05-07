//
//  LMMineViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 17/3/31.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMMineViewController.h"
#import "AliPayViews.h"
#import "KeychainData.h"
#import "SetpasswordViewController.h"
#import "MBProgressHUD.h"
#import "LMFeedBackViewController.h"
#import "LMSecuritySettingViewController.h"

@interface LMMineViewController () <UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    
    NSArray *_tableSource;
}

@end

@implementation LMMineViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor redColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView reloadData];
    [self.view addSubview:_tableView];
    
    _tableSource = @[@"客服热线",@"帮助中心",@"意见反馈",@"密码锁"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    }
    return 44.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _tableSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        LuHeaderCell* cell = [[LuHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        [cell setUserHeader:@"lizhead"];
        [cell setUserName:@"刘磊璐"];
        return cell;
    }
    static NSString* identifier = @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        cell.textLabel.text = _tableSource[indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18207485176"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            LMFeedBackViewController *nextCtl = [[LMFeedBackViewController alloc] init];
            [self.navigationController pushViewController:nextCtl animated:YES];
        }
            break;
        case 3:
        {
            LMSecuritySettingViewController *nextCtl = [[LMSecuritySettingViewController alloc] init];
            [self.navigationController pushViewController:nextCtl animated:YES];
            
//            [self forgotPassword];
//            SetpasswordViewController *setpass = [[SetpasswordViewController alloc] init];
//            setpass.string = @"重置密码";
//            [self presentViewController:setpass animated:YES completion:nil];
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
            [self forgotPassword];
            SetpasswordViewController *setpass = [[SetpasswordViewController alloc] init];
            setpass.string = @"重置密码";
            [self presentViewController:setpass animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}
/**
 *  忘记密码
 */
- (void)forgotPassword
{
    [KeychainData forgotPsw];
    [self hudAction:@"忘记密码"];
}

- (void)hudAction:(NSString *)contextStr
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = contextStr;
    hud.animationType = MBProgressHUDAnimationZoom;
    [hud showAnimated:YES];
    [self.view addSubview:hud];
    [self performSelector:@selector(removeHUB:) withObject:hud afterDelay:1];
    
}
- (void)removeHUB:(MBProgressHUD *)hud
{
    if (hud) {
        [hud  hideAnimated:YES];
        [hud removeFromSuperview];
        hud = nil;
    }
}

/**
 *  验证密码
 */
- (void)validatePassword
{
    BOOL isSave = [KeychainData isSave]; //是否有保存
    if (isSave) {
        
        SetpasswordViewController *setpass = [[SetpasswordViewController alloc] init];
        setpass.string = @"验证密码";
        [self presentViewController:setpass animated:YES completion:nil];
        
    } else {
        [self hudAction:@"还没有设置密码，不能直接登录"];
    }
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


@implementation LuHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _headerIcon.layer.cornerRadius = 30;
    
        _headerIcon.layer.masksToBounds = YES;
        _name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_headerIcon];
        [self.contentView addSubview:_name];
    };
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    _headerIcon.frame = CGRectMake((frame.size.width-60)/2.0, (frame.size.height-60)/2.0, 60, 60);
    _name.frame = CGRectMake(0, (frame.size.height-60)/2.0+70, SCREEN_WIDTH, 30);
    _name.textAlignment = NSTextAlignmentCenter;
    _name.textColor = [UIColor purpleColor];
}

- (void)setUserHeader:(NSString*)header{
    _headerIcon.image = [UIImage imageNamed:header];
    
}

- (void)setUserName:(NSString*)name{
    _name.text = name;
}

@end
