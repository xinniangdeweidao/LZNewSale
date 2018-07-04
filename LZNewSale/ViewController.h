//
//  ViewController.h
//  LZNewSale
//
//  Created by 李真 on 2018/7/4.
//  Copyright © 2018年 李真. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leftTableViewCell.h"
#import "rightTableViewCell.h"
#import "UIView+Convenience.h"
#import "UIView+WHView.h"
@interface ViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIScrollView * mainScrol;
@property (nonatomic,strong) UIScrollView * imgVScrol;
@property (nonatomic,strong) UITableView * leftTabV;
@property (nonatomic,strong) UITableView * rightTabV;
@property (nonatomic,copy) NSMutableArray * imgArr;
@property (nonatomic,strong) UIPageControl * pc;
@property (nonatomic,strong) UIView *backV;
@property (nonatomic,strong) UILabel * cabinetV;//柜子
@end

