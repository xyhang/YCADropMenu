//
//  ViewController.m
//  DropMenuDemo
//
//  Created by 网金科技 on 2017/9/12.
//
//

#import "ViewController.h"
#import "YCADropMenu.h"
@interface ViewController ()
@property (nonatomic , strong) YCADropMenu *menu;

@property (nonatomic , assign) NSInteger record_indexOne;
@property (nonatomic , assign) NSInteger record_indexTwo;

@property (nonatomic , assign) NSInteger one_record;
@property (nonatomic , assign) NSInteger two_record;
@property (nonatomic , assign) NSInteger three_record;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createMenuView];
    
}

#pragma mark -- 配置下拉菜单
-(void)createMenuView{
    
    NSArray *arr = @[@"产品分类",@"现货期货",@"产地国家",@"整柜零售"];
    self.menu = [[YCADropMenu alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44) withData:arr];
    [self.view addSubview:self.menu];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil][@"data"];

    NSArray *chanCatArray = dataDic[@"far_catid"];
    NSArray *xqCatArray = dataDic[@"sub_order"];
    NSArray *chandiArray = dataDic[@"sub_chandi"];
    NSArray *zlCatArray = dataDic[@"sub_retail"];
    NSDictionary *dic = @{@"dropStyle":@(DropListLinkStyle),@"data":chanCatArray};
    
    NSDictionary *dic1 = @{@"dropStyle":@(DropListStyle),@"data":xqCatArray};
    
    NSDictionary *dic2 = @{@"dropStyle":@(DropCollectionStyle),@"data":chandiArray};
    
    NSDictionary *dic3 = @{@"dropStyle":@(DropListStyle),@"data":zlCatArray};
    
    self.menu.index_one = _record_indexOne;
    self.menu.index_two = _record_indexTwo;
    self.menu.one_record_id = _one_record;
    self.menu.two_record_id = _two_record;
    self.menu.three_record_id = _three_record;
    [self.menu.dataArray addObjectsFromArray:@[dic,dic1,dic2,dic3]];
    self.menu.tapClickCellBlock = ^(NSString *titleStr, NSString *idStr,NSUInteger index, NSUInteger btnIndex) {
        if (btnIndex == 11) {
            _one_record = index;
        }else if (btnIndex == 12){
            _two_record = index;
        }else if (btnIndex == 13){
            _three_record = index;
        }
        NSLog(@"%@",titleStr);
    };
    
    self.menu.tapClickCellListBlock = ^(NSString *titleStr, NSString *idStr, NSUInteger index1, NSUInteger index2) {
        _record_indexOne = index1;
        _record_indexTwo = index2;
    };

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
