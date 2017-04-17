//
//  LMBaseViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 17/3/31.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMBaseViewController.h"
#import "UPWMUserInterfaceManager.h"

@interface LMBaseViewController ()

@end

@implementation LMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
