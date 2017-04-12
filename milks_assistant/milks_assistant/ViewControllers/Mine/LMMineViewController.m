//
//  LMMineViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 17/3/31.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMMineViewController.h"

@interface LMMineViewController () <UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    
    NSArray *_tableSource;
}

@end

@implementation LMMineViewController

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
    
    _tableSource = @[@"Lizzie",@"关于我们",@"客服热线",@"帮助中心",@"意见反馈",@"牛奶生活助手"];
    
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
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        LuHeaderCell* cell = [[LuHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        [cell setUserHeader:@"icon_header"];
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
