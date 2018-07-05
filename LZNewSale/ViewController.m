//
//  ViewController.m
//  LZNewSale
//
//  Created by 李真 on 2018/7/4.
//  Copyright © 2018年 李真. All rights reserved.
//

#import "ViewController.h"
//iOS11 顶部statusBar
#define IOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 导航栏高度
#define kNavbarHeight (iPhoneX ? 88.f : 64.f)
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCROL_Height 250
#define MES_HEIGHT   60
#define HOME_HEIGHT   (iPhoneX ? 34.f : 0.f)
@interface ViewController ()

@end

@implementation ViewController

- (UIScrollView *)imgVScrol{
    if (!_imgVScrol) {
        _imgVScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, SCROL_Height)];
        _imgVScrol.showsHorizontalScrollIndicator = NO;
        _imgVScrol.delegate = self;
       
        _imgVScrol.pagingEnabled = YES;
        
    }
    return _imgVScrol;
}
- (UITableView *)leftTabV{
    if (!_leftTabV) {
        _leftTabV = [[UITableView alloc]initWithFrame:CGRectMake(0,SCROL_Height + MES_HEIGHT+kNavbarHeight, 100, KSCREEN_HEIGHT - HOME_HEIGHT - SCROL_Height - MES_HEIGHT) style:UITableViewStylePlain];
        [_leftTabV registerNib:[UINib nibWithNibName:@"leftTableViewCell" bundle:nil] forCellReuseIdentifier:@"leftTableViewCellID"];
        _leftTabV.delegate = self;
        _leftTabV.dataSource = self;
        _leftTabV.showsVerticalScrollIndicator = NO;
    }
    return _leftTabV;
}
- (UIView *)backV{
    if (!_backV) {
        _backV =  [[UIView alloc]initWithFrame:CGRectMake(0, kNavbarHeight, KSCREEN_WIDTH, SCROL_Height + MES_HEIGHT)];
        _backV.userInteractionEnabled = YES;
    }
    return _backV;
}
- (UITableView *)rightTabV{
    if (!_rightTabV) {
        _rightTabV = [[UITableView alloc]initWithFrame:CGRectMake(100, self.leftTabV.y,KSCREEN_WIDTH - 100, self.leftTabV.frame.size.height) style:UITableViewStylePlain];
        [_rightTabV registerNib:[UINib nibWithNibName:@"rightTableViewCell" bundle:nil] forCellReuseIdentifier:@"rightTableViewCellID"];
        _rightTabV.delegate = self;
        _rightTabV.dataSource = self;
    }
    return _rightTabV;
}
- (NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"天才零售机";
   
    for (int i = 1; i < 5; i ++) {
        UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(KSCREEN_WIDTH*(i-1), 0, KSCREEN_WIDTH, CGRectGetHeight(self.imgVScrol.frame))];
        imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.imgVScrol addSubview:imgV];
        
    }
    self.imgVScrol.contentSize = CGSizeMake(KSCREEN_WIDTH * 4, 0);
    [self.backV addSubview:self.imgVScrol];
    //零售柜地址
    _cabinetV = [[UILabel alloc]initWithFrame:CGRectMake(10, self.imgVScrol.bottom, KSCREEN_WIDTH - 10*2, CGRectGetHeight(self.backV.frame) - self.imgVScrol.bottom)];
    _cabinetV.text = @"🚇 当前机柜:北京天安门广场贩卖机    ☎️ 联系商家";
    _cabinetV.font = [UIFont systemFontOfSize:16];
    [self.backV addSubview:_cabinetV];
     [self.view addSubview:self.backV];
    _pc = [[UIPageControl alloc]initWithFrame:CGRectMake(KSCREEN_WIDTH/2.0, self.imgVScrol.bottom - 30, 10, 10)];
    _pc.numberOfPages = 4;
    _pc.pageIndicatorTintColor = [UIColor orangeColor];
    _pc.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    [self.backV addSubview:_pc];
    [self createUI];
    if (IOS11_OR_LATER) {
        self.leftTabV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.rightTabV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}


- (void)createUI{
    self.leftTabV.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    self.rightTabV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.leftTabV];
    [self.view addSubview: self.rightTabV];
    
}
#pragma mark - scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.leftTabV])
    {
        CGFloat topHeight = self.backV.height;
        CGFloat offsetY = scrollView.contentOffset.y;
        
       NSLog(@"%f %.2f",offsetY, self.rightTabV.y);
        
        if (offsetY > topHeight)
        {
            self.backV.y =   - topHeight + kNavbarHeight;
            self.leftTabV.y = self.rightTabV.y = self.backV.bottom;
            self.leftTabV.height = self.rightTabV.height = KSCREEN_HEIGHT - kNavbarHeight - HOME_HEIGHT;
            
        }
        else if (offsetY < 0)
        {
            self.backV.y =  - offsetY+ kNavbarHeight;
            self.leftTabV.y =  self.rightTabV.y = self.backV.bottom;
            self.leftTabV.height = self.rightTabV.height =  KSCREEN_HEIGHT - self.backV.bottom - HOME_HEIGHT;
            
     
        }
        else
        {
            self.backV.y =  - offsetY+ kNavbarHeight;
            self.leftTabV.y =  self.rightTabV.y = self.backV.bottom;
            self.leftTabV.height =  self.rightTabV.height = KSCREEN_HEIGHT - self.backV.bottom - HOME_HEIGHT;
           
        }
        
    }
    else if ([scrollView isEqual:self.imgVScrol])
    {
        //        轮播图滚动
        _pc.currentPage = scrollView.contentOffset.x/KSCREEN_WIDTH;
//        scrollView.contentOffset = CGPointMake(KSCREEN_WIDTH*_pc.currentPage, 0);
    }
    
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.leftTabV]) {
        return 25;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.leftTabV]) {
        return 75;
    }
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.leftTabV]) {
        leftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"leftTableViewCellID" forIndexPath:indexPath];
        cell.leftLab.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
        cell.leftLab.textColor = [UIColor colorWithRed:0.42 green:0.42 blue:0.42 alpha:1.0];
        cell.leftLab.text = [NSString stringWithFormat:@"新品面包%ld",indexPath.row];
        return cell;
    }
    rightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"rightTableViewCellID" forIndexPath:indexPath];
    cell.nameLab.text = [NSString stringWithFormat:@"芝士 %ld",indexPath.row];
    cell.priceLab.text = [NSString stringWithFormat:@"￥%.2f",indexPath.row + 1 + 0.1*indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.leftTabV]) {
        leftTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.leftLab.backgroundColor = [UIColor whiteColor];
        
        cell.leftLab.textColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];
        
    }
    //    rightTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
