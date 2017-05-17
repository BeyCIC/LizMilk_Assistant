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
#import "LMHYSLizzieHelpViewController.h"

@interface LMMineViewController () <UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    UITableView *_tableView;
    
    NSArray *_tableSource;
    
    UIImage *userHeaderImg;
    
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
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self initView];
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserHeader];
    if (imageData) {
        userHeaderImg = [UIImage imageWithData:imageData];
    }
    if (!userHeaderImg) {
        userHeaderImg = [UIImage imageNamed:@"lizhead"];
    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [_tableView reloadData];
}

- (void)initView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
        [cell.headerIcon addTarget:self action:@selector(changeHeader:) forControlEvents:UIControlEventTouchUpInside];
//        [cell setUserHeader:@"lizhead"];
        [cell.headerIcon setBackgroundImage:userHeaderImg forState:UIControlStateNormal];
        [cell setUserName:@"刘磊璐"];
        return cell;
    }
    static NSString* identifier = @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if (indexPath.row != 4) {
            
            cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
            cell.textLabel.text = _tableSource[indexPath.row];
            cell.textLabel.textColor = [UIColor blackColor];
        } else {
            UIButton *loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 4.5, SCREEN_WIDTH - 50, 35)];
            [self setRoundBtn:loginOutBtn];
            [loginOutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
            [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
            [loginOutBtn setBackgroundColor:RGBCOLOR(57, 139, 251)];
            [cell.contentView addSubview:loginOutBtn];
        }
    }
    if (indexPath.section == 1 && indexPath.row != 4) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.000001;
    } else {
        NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:LoginUserName];

        if (username && ![username isEqualToString:@""]) {
            return 200;
        }
        return 0.000001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    } else {
        
        NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:LoginUserName];
        if (username && ![username isEqualToString:@""]) {
            UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            UIButton *loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 4.5 + 100, SCREEN_WIDTH - 60, 35)];
            [self setRoundBtn:loginOutBtn];
            [loginOutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
            [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
            [loginOutBtn setBackgroundColor:RGBCOLOR(57, 139, 251)];
            [footer addSubview:loginOutBtn];
            return footer;
        } else {
            return [[UIView alloc] initWithFrame:CGRectZero];
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }
    switch (indexPath.row) {
        case 0:
        {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18207485176"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 1:
        {
            LMHYSLizzieHelpViewController *loveLizzie = [[LMHYSLizzieHelpViewController alloc] init];
            [self.navigationController pushViewController:loveLizzie animated:YES];
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

- (void)Back:(UIButton*)sender {
    
}

- (void)changeHeader:(UIButton*)sender {
    
  UIAlertController *actionSheet  = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.allowsEditing = YES;
        
//        UIImage* image = [UP_GETIMG(@"bg_naviBar44") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
//        [imagepicker.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//        
        [imagepicker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
        [imagepicker.navigationBar setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
        imagepicker.navigationBar.tintColor = [UIColor blackColor];
        UIBarButtonItem *phoneButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(Back:)];
        imagepicker.navigationController.navigationItem.leftBarButtonItem = phoneButton;
        
        UIAlertAction *libActon = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagepicker animated:YES completion:nil];
        }];
        
        UIAlertAction *takeActon = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:imagepicker animated:YES completion:nil];
        }];
        UIAlertAction *cancelActon = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [actionSheet addAction:libActon];
        [actionSheet addAction:takeActon];
        [actionSheet addAction:cancelActon];
        [self presentViewController:actionSheet animated:YES completion:nil];
    } else{
        [self showAlertWithTitle:@"提示" msg:@"请设置访问权限" ok:@"确定" cancel:nil];
    }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *selImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!selImage) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LuHeaderCell* cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell.headerIcon setBackgroundImage:selImage forState:UIControlStateNormal];
        
    });
    
    
    UIAlertController *alertSheet  = [UIAlertController alertControllerWithTitle:@"确定要更改吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureActon = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        userHeaderImg = selImage;
        NSData *imageData = UIImagePNGRepresentation(userHeaderImg);
        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:LoginUserHeader];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }];
    UIAlertAction *cancelActon = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            LuHeaderCell* cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [cell.headerIcon setBackgroundImage:userHeaderImg forState:UIControlStateNormal];
        });
        
    }];
    [alertSheet addAction:sureActon];
    [alertSheet addAction:cancelActon];
    [self presentViewController:alertSheet animated:YES completion:nil];

}

- (void)logout:(UIButton*)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:LogoutPostnotificationName object:nil];
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
        
        _headerIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerIcon.frame = CGRectMake((SCREEN_WIDTH-60)/2, 0, 60, 60);
        _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _headerIcon.layer.cornerRadius = 30;
    
        _headerIcon.layer.masksToBounds = YES;
        _name.textAlignment = NSTextAlignmentCenter;
        _headerIcon.frame = CGRectMake((SCREEN_WIDTH-60)/2.0, (120)/2.0, 60, 60);
        _name.frame = CGRectMake(0, (120)/2.0+70, SCREEN_WIDTH, 30);
        _name.textAlignment = NSTextAlignmentCenter;
        _name.textColor = [UIColor purpleColor];
        [self.contentView addSubview:_headerIcon];
        [self.contentView addSubview:_name];
    };
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    _headerIcon.frame = CGRectMake((SCREEN_WIDTH-60)/2.0, (120)/2.0, 60, 60);
    _name.frame = CGRectMake(0, (120)/2.0+70, SCREEN_WIDTH, 30);
    _name.textAlignment = NSTextAlignmentCenter;
    _name.textColor = [UIColor purpleColor];
    [self.contentView addSubview:_headerIcon];
    [self.contentView addSubview:_name];
}

- (void)setUserHeader:(NSString*)header{
    [_headerIcon setBackgroundImage:[UIImage imageNamed:header] forState:UIControlStateNormal];
}

- (void)setUserName:(NSString*)name{
    _name.text = name;
}

@end
