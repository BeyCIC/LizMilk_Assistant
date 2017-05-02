//
//  DashBoardViewController.m
//  MoveDemo
//
//  Created by lulu on 16/8/15.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import "DashBoardViewController.h"
#import "DashCollectionViewFlowLayout.h"
#import "DashBoardCollectionViewCell.h"

#import "UIColor+NSString.h"
#import "DashBoardModel.h"

#import "PhotoDIYViewController.h"
#import "ViewController.h"

#import "SetpasswordViewController.h"
#import "KeychainData.h"

@interface DashBoardViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    DashCollectionViewFlowLayout * layout;
    UIView *tempMoveCell;
    UICollectionViewCell * originalIndexPathCell;
    // 提示没有指标的label
    UILabel * label;
}

//分享按钮
@property (nonatomic , strong) UIButton * shareButton;

//nav上显示的时间字符串
@property (nonatomic , strong) NSString * DataString;
//选中的cell对应的dashModel
@property (nonatomic , strong)  DashBoardModel * dashModel;
//dashBoard界面的collectionView
@property (nonatomic  , strong) UICollectionView * collectionView;
typedef NS_ENUM(NSUInteger, XWDragCellCollectionViewScrollDirection) {
    XWDragCellCollectionViewScrollDirectionNone = 0,
    XWDragCellCollectionViewScrollDirectionLeft,
    XWDragCellCollectionViewScrollDirectionRight,
    XWDragCellCollectionViewScrollDirectionUp,
    XWDragCellCollectionViewScrollDirectionDown
};


/**长按多少秒触发拖动手势，默认1秒，如果设置为0，表示手指按下去立刻就触发拖动*/
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;
/**是否开启拖动到边缘滚动CollectionView的功能，默认YES*/
@property (nonatomic, assign) BOOL edgeScrollEable;
/**是否开启拖动的时候所有cell抖动的效果，默认YES*/
@property (nonatomic, assign) BOOL shakeWhenMoveing;
/**抖动的等级(1.0f~10.0f)，默认4*/
@property (nonatomic, assign) CGFloat shakeLevel;
@property (nonatomic, weak) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) NSIndexPath *originalIndexPath;
@property (nonatomic, strong) NSIndexPath *moveIndexPath;
//@property (nonatomic, weak) UIView *tempMoveCell;
@property (nonatomic, strong) CADisplayLink *edgeTimer;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) XWDragCellCollectionViewScrollDirection scrollDirection;
@property (nonatomic, assign) CGFloat oldMinimumPressDuration;
@property (nonatomic, assign, getter=isObservering) BOOL observering;
#define angelToRandian(x)  ((x)/180.0*M_PI)
@end

@implementation DashBoardViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}


- (NSMutableArray *)DashModelArray
{
    if (_DashModelArray == nil) {
        _DashModelArray = [NSMutableArray array];
    }
    return _DashModelArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad {

    [self makeDate];
    UIColor * color = [UIColor whiteColor];
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    // 设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor =NavigationColor;
    // 设置半透明状态（yes） 不透明状态 （no）
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    // 设置导航栏上面字体的颜色
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"牛奶璐";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *phoneButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_add_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(photoDIY:)];
    self.navigationItem.rightBarButtonItem = phoneButton;
    
    [self makeCollectionView];
    BOOL isSave = [KeychainData isSave]; //是否有保存
    if (isSave) {
        
        SetpasswordViewController *setpass = [[SetpasswordViewController alloc] init];
        setpass.string = @"验证密码";
        [self presentViewController:setpass animated:YES completion:nil];
    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)photoDIY:(UIButton*)sender {
    PhotoDIYViewController *nextCtl = [[PhotoDIYViewController alloc] init];
    
    [self.navigationController pushViewController:nextCtl animated:YES];
}

- (void)makeCollectionView
{
    layout = [[DashCollectionViewFlowLayout alloc] init];
    layout.DashModelArray = [_DashModelArray mutableCopy];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KBianJu, Main_Screen_Width, Main_Screen_Height-NavgationHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
 
    [_collectionView registerClass:[DashBoardCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    // 创建长按手势
    [self xwp_addGesture];
}
- (void)makeDate
{
    NSString * filePath = [[NSBundle mainBundle]pathForResource:@"dateAll" ofType:@"txt"];
    
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    
    //  NSMutableDictionary * dictqq = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray * array =   [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    _DashModelArray = [NSMutableArray array];
    for ( NSMutableDictionary * dict in array) {
      
        DashBoardModel * m = [[DashBoardModel alloc] init];
        [m setValuesForKeysWithDictionary:dict];
        [_DashModelArray addObject:m];
        
    }
}

#pragma collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _DashModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell"];
    
    DashBoardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    DashBoardModel * m = nil;
    m = _DashModelArray[indexPath.row];
    cell.backgroundColor = [UIColor colorWithString:m.color];
    [cell setTextColor:[UIColor whiteColor]];
    cell.labelTitle.text = m.title;
     return cell;
    
}
// 选中cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showAlertWithTitle:@"0_0" msg:@"使劲点我吧@" ok:@"亲亲😘" cancel:@"忍痛割爱"];
}

/**
 *  添加一个自定义的滑动手势
 */
- (void)xwp_addGesture{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(xwp_longPressed:)];
    _longPressGesture = longPress;
    _minimumPressDuration = 0.5;
    longPress.minimumPressDuration = _minimumPressDuration;
    [self.collectionView addGestureRecognizer:longPress];
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/**
 *  监听手势的改变
 */
- (void)xwp_longPressed:(UILongPressGestureRecognizer *)longPressGesture{
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        _originalIndexPath = [self.collectionView indexPathForItemAtPoint:[longPressGesture locationOfTouch:0 inView:longPressGesture.view]];
        [_collectionView beginInteractiveMovementForItemAtIndexPath:_originalIndexPath];
        originalIndexPathCell = [_collectionView cellForItemAtIndexPath:_originalIndexPath];
        tempMoveCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, originalIndexPathCell.frame.size.width , originalIndexPathCell.frame.size.height)];
        [tempMoveCell addSubview: originalIndexPathCell.contentView];
        
        //        tempMoveCell.center = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
        tempMoveCell.layer.masksToBounds = YES; //设置为yes，就可以使用圆角
        tempMoveCell.layer.cornerRadius= 3; //设置它的圆角大小
        tempMoveCell.center = originalIndexPathCell.center;
        tempMoveCell.backgroundColor =  originalIndexPathCell.backgroundColor;
        [_collectionView addSubview:tempMoveCell];
        [tempMoveCell bringSubviewToFront:_collectionView];
        originalIndexPathCell.hidden = YES;
        
        _edgeScrollEable = YES;
        _shakeWhenMoveing = YES;
        _shakeLevel = 0.5f;
        //开启边缘滚动定时器
        [self xwp_setEdgeTimer];
        [self  xw_enterEditingModel];
        NSLog(@"手势开始");
    }
    if (longPressGesture.state == UIGestureRecognizerStateChanged) {
        
        tempMoveCell.center = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
        NSLog(@"手势改变");
    }
    if (longPressGesture.state == UIGestureRecognizerStateCancelled){
        [self xwp_stopEdgeTimer];
        
        [_collectionView cancelInteractiveMovement];
        
    }
    if (longPressGesture.state == UIGestureRecognizerStateEnded){
        [self xwp_stopEdgeTimer];
        [self  xw_stopEditingModel];

        [_collectionView endInteractiveMovement];
        [tempMoveCell removeFromSuperview];
        originalIndexPathCell.hidden = NO;
        [originalIndexPathCell addSubview:originalIndexPathCell.contentView];
        NSIndexPath * path = [_collectionView indexPathForItemAtPoint:[longPressGesture locationOfTouch:0 inView:longPressGesture.view]];
        DashBoardModel * model = [_DashModelArray objectAtIndex:_originalIndexPath.row];
        [_DashModelArray   removeObject:model];
        [_DashModelArray   insertObject:model atIndex:path.row];
        layout.DashModelArray = _DashModelArray;
        [_collectionView reloadData];
        
    }
    
}

//#pragma ＝＝＝＝＝＝＝＝＝ （重新排列指标model 使1X1指标 没有空缺 ，之后一个空缺指标放到最后,此demo中没有用到）
//
//- (void)makeNewDashModelArray
//{
//    NSNumber * index = 0;
//    // 1X1 指标数组
//    NSMutableArray * sizeoneArray = [NSMutableArray array];
//    // 1X1 指标在全部指标数组中的下标
//    NSMutableArray * sizeoneindexArray = [NSMutableArray array];
//    
//    for (DashBoardModel * m in _DashModelArray) {
//        
//        if (m.size_x == 1 && m.size_y == 1) {
//            
//            index = [NSNumber numberWithInteger:[_DashModelArray indexOfObject:m]];
//            // 把所有1X1的指标存储到数组中
//            [sizeoneArray addObject:m];
//            // 把所有1X1指标在全部指标中的下标存储到数组中
//            [sizeoneindexArray addObject:index];
//            
//        }
//    }
//    if (sizeoneindexArray.count != 0) {
//        
//        for (int i = 0; i <= sizeoneindexArray.count-1;i++) {
//            //1X1 指标在全部指标数组中的下标
//            NSInteger xiabiao = [sizeoneindexArray[i] integerValue];
//            
//            DashBoardModel * modelqian = [[DashBoardModel alloc] init];
//            //            DashBoardModel * modelhou =[[DashBoardModel alloc] init];
//            DashBoardModel * modelhou = nil;
//            if ( ((i+1)%2 != 0) && (i == sizeoneindexArray.count -1)) {
//                
//                // 删除最后一个1X1指标
//                DashBoardModel * biandongModel = _DashModelArray[[sizeoneindexArray[i] integerValue]];
//                
//                [_DashModelArray removeObject:biandongModel];
//                
//                // 添加到全部指标的最后指标
//                [_DashModelArray addObject:biandongModel];
//                
//                NSNumber * insertNumber = [NSNumber numberWithInteger:[_DashModelArray indexOfObject:_DashModelArray.lastObject]];
//                
//                [sizeoneindexArray  replaceObjectAtIndex:i withObject:insertNumber];
//                
//            }else if(i != sizeoneindexArray.count -1){
//                
//                if ((xiabiao == 0) && (sizeoneindexArray.count > 1)) {
//                    
//                    modelhou = _DashModelArray[xiabiao + 1];
//                    
//                }else{
//                    
//                    modelqian = _DashModelArray[xiabiao - 1];
//                    modelhou = _DashModelArray[xiabiao + 1];
//                }
//                
//                if (TiaojianOne | TiaojianTwo | TiaojianThree){
//                    // 删除指标
//                    DashBoardModel * changeModel = _DashModelArray[[sizeoneindexArray[i+1] integerValue]];
//                    
//                    [_DashModelArray removeObject:changeModel];
//                    // 插入指标
//                    [_DashModelArray insertObject:changeModel atIndex:xiabiao+1];
//                    
//                    NSNumber * insertNumber = [NSNumber numberWithInteger:(xiabiao + 1)];
//                    
//                    [sizeoneindexArray  replaceObjectAtIndex:i+1 withObject:insertNumber];
//                    
//                }else{
//                    
//                }
//                
//            }
//        }
//    }else{
//        
//        NSLog(@"被选中的指标没有一程一大小的指标");
//    }
//    
//}

#pragma ====＝＝＝抖动
- (void)xw_enterEditingModel{
    _oldMinimumPressDuration =  _longPressGesture.minimumPressDuration;
    _longPressGesture.minimumPressDuration = 0;
    if (_shakeWhenMoveing) {
        [self xwp_shakeAllCell];
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xwp_foreground) name:UIApplicationWillEnterForegroundNotification object:nil];

    }
}

- (void)xw_stopEditingModel{
   
    _longPressGesture.minimumPressDuration = _oldMinimumPressDuration;
    [self xwp_stopShakeAllCell];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}
- (void)xwp_shakeAllCell{
    CAKeyframeAnimation* anim=[CAKeyframeAnimation animation];
    anim.keyPath=@"transform.rotation";
    anim.values=@[@(angelToRandian(-_shakeLevel)),@(angelToRandian(_shakeLevel)),@(angelToRandian(-_shakeLevel))];
    anim.repeatCount=MAXFLOAT;
    anim.duration=0.2;
    NSArray *cells = [self.collectionView visibleCells];
    for (UICollectionViewCell *cell in cells) {
        /**如果加了shake动画就不用再加了*/
        if (![cell.layer animationForKey:@"shake"]) {
            [cell.layer addAnimation:anim forKey:@"shake"];
        }
    }
    if (![tempMoveCell.layer animationForKey:@"shake"]) {
        [tempMoveCell.layer addAnimation:anim forKey:@"shake"];
    }
}
- (void)xwp_stopShakeAllCell{
    if (!_shakeWhenMoveing) {
        return;
    }
    NSArray *cells = [self.collectionView visibleCells];
    for (UICollectionViewCell *cell in cells) {
        [cell.layer removeAllAnimations];
    }
    [tempMoveCell.layer removeAllAnimations];
    [self removeObserver:self forKeyPath:@"contentOffset"];
}


#pragma mark - timer methods

- (void)xwp_setEdgeTimer{
    if (!_edgeTimer && _edgeScrollEable) {
        _edgeTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(xwp_edgeScroll)];
        [_edgeTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)xwp_stopEdgeTimer{
    if (_edgeTimer) {
        [_edgeTimer invalidate];
        _edgeTimer = nil;
    }
}
- (void)xwp_edgeScroll{
    [self xwp_setScrollDirection];
    switch (_scrollDirection) {
        case XWDragCellCollectionViewScrollDirectionLeft:{
            //这里的动画必须设为NO
            [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x - 4, self.collectionView.contentOffset.y) animated:NO];
            tempMoveCell.center = CGPointMake(tempMoveCell.center.x - 4,tempMoveCell.center.y);
            _lastPoint.x -= 4;
            
        }
            break;
        case XWDragCellCollectionViewScrollDirectionRight:{
            [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + 4, self.collectionView.contentOffset.y) animated:NO];
            tempMoveCell.center = CGPointMake(tempMoveCell.center.x + 4, tempMoveCell.center.y);
            _lastPoint.x += 4;
            
        }
            break;
        case XWDragCellCollectionViewScrollDirectionUp:{
            [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y - 4) animated:NO];
            tempMoveCell.center = CGPointMake(tempMoveCell.center.x, tempMoveCell.center.y - 4);
            _lastPoint.y -= 4;
        }
            break;
        case XWDragCellCollectionViewScrollDirectionDown:{
            [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y + 4) animated:NO];
            tempMoveCell.center = CGPointMake(tempMoveCell.center.x, tempMoveCell.center.y + 4);
            _lastPoint.y += 4;
        }
            break;
        default:
            break;
    }
    
}

- (void)xwp_setScrollDirection{
    _scrollDirection = XWDragCellCollectionViewScrollDirectionNone;
    
    if (self.collectionView.bounds.size.height + self.collectionView.contentOffset.y - tempMoveCell.center.y < tempMoveCell.bounds.size.height / 2 && self.collectionView.bounds.size.height + self.collectionView.contentOffset.y < self.collectionView.contentSize.height) {
        _scrollDirection = XWDragCellCollectionViewScrollDirectionDown;
    }
    if (tempMoveCell.center.y - self.collectionView.contentOffset.y < tempMoveCell.bounds.size.height / 2 && self.collectionView.contentOffset.y > 0) {
        _scrollDirection = XWDragCellCollectionViewScrollDirectionUp;
    }
    if (self.collectionView.bounds.size.width + self.collectionView.contentOffset.x - tempMoveCell.center.x < tempMoveCell.bounds.size.width / 2 && self.collectionView.bounds.size.width + self.collectionView.contentOffset.x < self.collectionView.contentSize.width) {
        _scrollDirection = XWDragCellCollectionViewScrollDirectionRight;
    }
    
    if (tempMoveCell.center.x - self.collectionView.contentOffset.x < tempMoveCell.bounds.size.width / 2 && self.collectionView.contentOffset.x > 0) {
        _scrollDirection = XWDragCellCollectionViewScrollDirectionLeft;
    }
}
- (void)xwp_foreground{
    [self xwp_shakeAllCell];
    
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
