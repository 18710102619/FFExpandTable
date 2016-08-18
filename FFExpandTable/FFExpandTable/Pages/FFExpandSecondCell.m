//
//  FFExpandSecondCell.m
//  FFExpandTable
//
//  Created by 张玲玉 on 16/8/17.
//  Copyright © 2016年 bj.zly.com. All rights reserved.
//

#import "FFExpandSecondCell.h"

@implementation FFExpandSecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)setModel:(FFExpandModel *)model
{
    _model=model;
    _model.secondCellHeight= (arc4random() % 300) + 50;
}

@end
