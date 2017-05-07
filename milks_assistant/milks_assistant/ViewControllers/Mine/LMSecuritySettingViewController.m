//
//  LMSecuritySettingViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 2017/5/2.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMSecuritySettingViewController.h"

@interface LMSecuritySettingViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_mainTable;
    
}

@end

@implementation LMSecuritySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    
    [self.view addSubview:_mainTable];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    
    

    return cell;
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
