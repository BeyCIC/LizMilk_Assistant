//
//  LMBaseViewController.m
//  milks_assistant
//  爱你一生一世，刘磊璐
//  Create by JasonHuang on 17/3/31
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMBaseViewController.h"
#import "UPWMUserInterfaceManager.h"
#import "KeychainData.h"
#import "SetpasswordViewController.h"
#import "LMTouchIDManager.h"

@interface LMBaseViewController ()

@end

@implementation LMBaseViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showGestureValide:) name:@"sholdShowGestValide" object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)showGestureValide:(NSNotification*)notification {
 
    BOOL isBackground = [[NSUserDefaults standardUserDefaults] boolForKey:@"isEnterBackground"];
    if (isBackground) {
        BOOL isSave = [KeychainData isSave]; //是否有保存
        if (isSave) {
            
            self.gestureCtl = [[SetpasswordViewController alloc] init];
            self.gestureCtl.string = @"验证密码";
            [self presentViewController:self.gestureCtl animated:YES completion:^{
                if ([[LMTouchIDManager sharedInstance] currentUserSetTouchID]) {
                    if ([[LMTouchIDManager sharedInstance] isTouchIdAvailable]) {
                        //使用指纹解锁
                        [[LMTouchIDManager sharedInstance] evaluatePolicy: @"通过Home键验证已有手机指纹" fallbackTitle:@"" SuccesResult:^{
                            [self.gestureCtl dismissViewControllerAnimated:YES completion:nil];
                        } FailureResult:^(LAError result){
                            //验证不成功或取消无操作
                        }];
                    } else {
                    }
                }
            }];
            
        } else if ([[LMTouchIDManager sharedInstance] currentUserSetTouchID]) {
            if ([[LMTouchIDManager sharedInstance] isTouchIdAvailable]) {
                //使用指纹解锁
                [[LMTouchIDManager sharedInstance] presentTouchIDVC];
            } else {
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isEnterBackground"];
    }
}


- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg ok:(NSString *)ok cancel:(NSString *)cancel{
    
    NSString* cancelButtonTitle = nil;
    if (cancel) {
        cancelButtonTitle = [NSString stringWithString:cancel];
    }
    
    NSString* otherButtonTitle = nil;
    if (ok) {
        otherButtonTitle = [NSString stringWithString:ok];
    }
    
    [[UPWMUserInterfaceManager sharedManager] showAlertWithTitle:title message:msg cancelButtonTitle:cancelButtonTitle otherButtonTitle:otherButtonTitle completeBlock:^(UPXAlertView *alertView, NSInteger buttonIndex) {
        if(buttonIndex==[UPXAlertView cancelButtonIndex]) {
            
        }
        else {
            
        }
    }];
}

- (void)setRoundBtn:(UIButton*)button {
    
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
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
