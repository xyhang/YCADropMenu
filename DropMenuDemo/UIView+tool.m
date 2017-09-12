//
//  UIView+tool.m
//  常用类别工具
//
//  Created by yan on 16/7/13.
//  Copyright © 2016年 nawei. All rights reserved.
//

#import "UIView+tool.h"

@implementation UIView (tool)

#pragma mark [frame]
// [GET方法]

- (CGFloat)v_x{
    return self.frame.origin.x;
}

- (CGFloat)v_y{
    return self.frame.origin.y;
}

- (CGFloat)v_w{
    return self.frame.size.width;
}

- (CGFloat)v_h{
    return self.frame.size.height;
}

// [SET方法]

- (void)setV_x:(CGFloat)v_x{
    self.frame = CGRectMake(v_x, self.v_y, self.v_w, self.v_h);
}

- (void)setV_y:(CGFloat)v_y{
    self.frame = CGRectMake(self.v_x, v_y, self.v_w, self.v_h);
}

- (void)setV_w:(CGFloat)v_w{
    self.frame = CGRectMake(self.v_x, self.v_y, v_w, self.v_h);
}

- (void)setV_h:(CGFloat)v_h{
    self.frame = CGRectMake(self.v_x, self.v_y, self.v_w, v_h);
}


- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


#pragma mark [layer]

- (CGFloat)v_cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setV_cornerRadius:(CGFloat)v_cornerRadius{
    self.layer.cornerRadius = v_cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
