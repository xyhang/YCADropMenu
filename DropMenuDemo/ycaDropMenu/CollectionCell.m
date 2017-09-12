//
//  CollectionCell.m
//  roujiaosuo
//
//  Created by 网金科技 on 2017/8/25.
//  Copyright © 2017年 keji. All rights reserved.
//

#import "CollectionCell.h"
#import "UIColor+tool.h"
@implementation CollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithHexString:@"EEEFF0"].CGColor;
    // Initialization code
}

@end
