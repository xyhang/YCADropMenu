//
//  YCADropMenu.h
//  roujiaosuo
//
//  Created by 网金科技 on 2017/8/24.
//  Copyright © 2017年 keji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kMenuBtnHeight 44
#define kItemNum 4   /// collection模式 每行多少个
#define kMenuCellSeletedBGColor [UIColor colorWithHexString:@"EFFCF2"]
#define kMenuCellSelectedColor [UIColor colorWithHexString:@"129E3F"]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface MenuModel : NSObject

@property (nonatomic , copy)NSString *titleStr;
@property (nonatomic , copy)NSString *idStr;
@property (nonatomic , assign)BOOL isSelected;

@end

typedef enum : NSUInteger {
    DropDefaultStyle = 0, /// 默认风格
    DropListStyle,        /// 一级下拉列表
    DropListLinkStyle,    /// 二级联动列表
    DropCollectionStyle   /// collection风格
} DropStyle;


@interface YCADropMenu : UIView

/// 下拉风格
@property (nonatomic , assign) DropStyle dropStyle;

/// 数据源 格式定义@[@[@{@"dropStle":dropStle,@"data":data}],....]
@property (nonatomic , strong) NSMutableArray *dataArray;


/// 用于记录点击哪一个(双列表)
@property (nonatomic , assign) NSInteger index_one;
@property (nonatomic , assign) NSInteger index_two;


/**** 目前不用了 ****/
/// 用于记录点击哪一个(单列表)
@property (nonatomic , assign) NSInteger one_record_id;
@property (nonatomic , assign) NSInteger two_record_id;
@property (nonatomic , assign) NSInteger three_record_id;
@property (nonatomic , assign) NSInteger record_id;

/// 用于记录点击那个按钮
@property (nonatomic , assign) NSInteger record_btnTag;

/**** 目前不用了 ****/


/// 选中的标题 id 和 index button
@property (nonatomic , copy) void(^tapClickCellBlock)(NSString *titleStr,NSString *idStr,NSUInteger index,NSUInteger buttonIndex);

/// 选中标题 id index
@property (nonatomic , copy) void(^tapClickCellListBlock)(NSString *titleStr,NSString *idStr,NSUInteger index1,NSUInteger index2);

/// 初始化操作
-(instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)arr;

/// 收回操作
-(void)takeMenuBack;



@end
