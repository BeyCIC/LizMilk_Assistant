//
//  LMDairyViewController.m
//  milks_assistant
//
//  Created by Jason Huang on 17/4/4.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMDairyListViewController.h"
#import "LMAddDairyViewController.h"
#import "LMReadDairyViewController.h"
#import "Util.h"

@interface LMDairyListViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_mainTable;
    NSMutableArray *_dataArr;
}

@end

@implementation LMDairyListViewController

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
//    [self setTitle:@"磊璐的日记"];
    UIColor * color = [UIColor whiteColor];
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    // 设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor = NavigationColor;
    // 设置半透明状态（yes） 不透明状态 （no）
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    // 设置导航栏上面字体的颜色
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"日记";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_dataArr removeAllObjects];
    NSArray *dairyArr = LizzieDairyDataInfo.getDairyObjects;
    [_dataArr addObjectsFromArray:dairyArr];
    [_mainTable reloadData];
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
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"dairyCell";
    lizzieDairyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[lizzieDairyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        
    }
    [cell setInfo:_dataArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LMReadDairyViewController *readCtl = [[LMReadDairyViewController alloc] init];
    readCtl.dairyInfo = _dataArr[indexPath.row];
    [self.navigationController pushViewController:readCtl animated:YES];
    
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


@implementation lizzieDairyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.note_icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53, 114)];
        self.note_icon.image = [UIImage imageNamed:@"note_icon"];
        
        self.dairyContent = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, SCREEN_WIDTH-30, 50)];
        self.dairyContent.textAlignment = NSTextAlignmentLeft;
        self.dairyContent.font = [UIFont systemFontOfSize:15];
        self.dairyContent.textColor = [UIColor blackColor];
        
        
        self.dairyMood = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 30)];
        self.dairyMood.textAlignment = NSTextAlignmentCenter;
        self.dairyMood.textColor = [UIColor purpleColor];
        self.dairyMood.font = [UIFont systemFontOfSize:15];
        
        self.dairyDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
        self.dairyDate.textAlignment = NSTextAlignmentRight;
        self.dairyDate.font = [UIFont systemFontOfSize:15];
//        self.dairyDate.textColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.note_icon];
        [self.contentView addSubview:_dairyContent];
//        [self.contentView addSubview:_dairyMood];
        [self.contentView addSubview:_dairyDate];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    self.note_icon.frame = CGRectMake(0, 0, 27, 50);
    self.dairyContent.frame = CGRectMake(40, 20, SCREEN_WIDTH-65, frame.size.height-25-10);
    self.dairyMood.frame = CGRectMake(5, frame.size.height-25-10, SCREEN_WIDTH-30, 50);
    self.dairyDate.frame = CGRectMake(frame.size.width-150, frame.size.height-25-10, 140, 25);
}

- (void)setInfo:(LizzieDiaryModel *)info {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [dateFormatter dateFromString:info.time];
    self.dairyContent.text = info.diaryContent;
    self.dairyMood.text = info.mood;
    self.dairyDate.text = [NSString stringWithFormat:@"%@",[Util calculateDateWith:date]];
}

@end
