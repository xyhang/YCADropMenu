//
//  UIView+tool.h
//  常用类别工具
//
//  Created by yan on 16/7/13.
//  Copyright © 2016年 nawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (tool)

#pragma mark [frame]

/**
 *  view的x(横)坐标
 */
@property (nonatomic, assign)CGFloat v_x;
/**
 *  view的y(纵)坐标
 */
@property (nonatomic, assign)CGFloat v_y;
/**
 *  view的宽度
 */
@property (nonatomic, assign)CGFloat v_w;
/**
 *  view的高度
 */
@property (nonatomic, assign)CGFloat v_h;

@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;


#pragma mark [layer]

/**
 *  view的圆角半径
 */
@property (nonatomic, assign)CGFloat v_cornerRadius;


@end
