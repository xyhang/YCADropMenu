//
//  TwoCell.m
//  roujiaosuo
//
//  Created by 网金科技 on 2017/8/24.
//  Copyright © 2017年 keji. All rights reserved.
//

#import "TwoCell.h"
#import "UIColor+tool.h"
@implementation TwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithHexString:@"e5e5e5"].CGColor;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}


@end
