//
//  rightTableViewCell.m
//  LZNewSale
//
//  Created by 李真 on 2018/7/4.
//  Copyright © 2018年 李真. All rights reserved.
//

#import "rightTableViewCell.h"

@implementation rightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bugBtn.layer.cornerRadius = 15;
    _bugBtn.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
