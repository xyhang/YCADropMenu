//
//  UIColor+tool.h
//  Ihere
//
//  Created by yan on 16/7/22.
//  Copyright © 2016年 haierwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (tool)


+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
