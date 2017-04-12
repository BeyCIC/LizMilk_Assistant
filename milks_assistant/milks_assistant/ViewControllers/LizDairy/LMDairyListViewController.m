//
//  LMDairyViewController.m
//  milks_assistant
//
//  Created by Jason Huang on 17/4/4.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMDairyListViewController.h"
#import "LMAddDairyViewController.h"
#import "LizzieDairyDataInfo.h"

@interface LMDairyListViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_mainTable;
    NSMutableArray *_dataArr;
}

@end

@implementation LMDairyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"磊璐的日记"];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_dataArr removeAllObjects];
    NSArray *dairyArr = LizzieDairyDataInfo.getDairyObjects;
    [_dataArr addObjectsFromArray:dairyArr];
}

- (void)initView {
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_mainTable];
    
    UIBarButtonItem *phoneButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_add_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(addDairy)];
    self.navigationItem.rightBarButtonItem = phoneButton;
    
    _dataArr = [[NSMutableArray alloc] initWithCapacity:1];
}

- (void)addDairy {
    
    LMAddDairyViewController *nextCtl = [[LMAddDairyViewController alloc] init];
    [self.navigationController pushViewController:nextCtl animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"dairyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
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
