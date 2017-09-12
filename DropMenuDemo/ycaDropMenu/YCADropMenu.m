//
//  YCADropMenu.m
//  roujiaosuo
//
//  Created by 网金科技 on 2017/8/24.
//  Copyright © 2017年 keji. All rights reserved.
//

#import "YCADropMenu.h"
#import "UIButton+ImageTitleSpace.h"
#import "OneCell.h"
#import "TwoCell.h"
#import "ListCell.h"
#import "CollectionCell.h"
#import "UIColor+tool.h"
#import "UIView+tool.h"

@implementation MenuModel


@end

@interface YCADropMenu ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    CGFloat cellHeight;
    CGFloat itemW;
    CGFloat itemH;
    UIButton *btn;
}

/// 蒙版
@property (nonatomic , strong) UIView *maskBackView;

/// 单列表
@property (nonatomic , strong) UITableView *tableView;

/// 左侧列表
@property (nonatomic , strong) UITableView *oneTableView;
/// 右侧列表
@property (nonatomic , strong) UICollectionView *twoCollectionView;



@property (nonatomic , strong) UICollectionViewFlowLayout *twoLayout;


@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *layout;




/// 临时按钮 用于处理变化的标题
@property (nonatomic , strong) UIButton *tempBtn;





// 数据模块
@property (nonatomic , strong) NSMutableArray *btnArray;

@property (nonatomic , strong) NSDictionary *dataDict;

/// 左侧数据
@property (nonatomic , strong) NSMutableArray * oneDataArray;
/// 右侧数据
@property (nonatomic , strong) NSMutableArray * twoDataArray;
/// 列表数据
@property (nonatomic , strong) NSMutableArray * listArray;


@end

@implementation YCADropMenu

-(instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)arr{
    if (self == [super initWithFrame:frame]) {
        self.dataArray = [[NSMutableArray array] mutableCopy];
        self.btnArray = [[NSMutableArray array] mutableCopy];
        self.oneDataArray = [[NSMutableArray array] mutableCopy];
        self.twoDataArray = [[NSMutableArray array] mutableCopy];
        self.listArray = [[NSMutableArray array] mutableCopy];
        
        [self configViewWithArray:arr];

        [self addSubview:self.maskBackView];
        [self sendSubviewToBack:self.maskBackView];
        [self addSubview:self.tableView];
        [self addSubview:self.oneTableView];
        [self addSubview:self.twoCollectionView];
        [self addSubview:self.collectionView];
    
    }
    return self;
}


#pragma mark -- 页面配置
-(void)configViewWithArray:(NSArray *)arr{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kMenuBtnHeight)];
    UIView *lview = [[UIView alloc]initWithFrame:CGRectMake(0, kMenuBtnHeight+1, SCREEN_WIDTH, 1)];
    [view addSubview:lview];
    view.backgroundColor = [UIColor colorWithHexString:@"F8F9FA"];
    CGFloat btnWdith = SCREEN_WIDTH/arr.count;
    for (int i = 0; i<arr.count; i++) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*btnWdith, 0, btnWdith, kMenuBtnHeight);
        btn.tag = i+10;
        [btn addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"drop_n"] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setImage:[UIImage imageNamed:@"drop_c"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithHexString:@"404653"] forState:UIControlStateNormal];
        [btn setTitleColor:kMenuCellSelectedColor forState:UIControlStateSelected];

        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:1];
        [view addSubview:btn];
        UIView *lv = [[UIView alloc]initWithFrame:CGRectMake(btnWdith-1, 5, 1, kMenuBtnHeight-10)];
        lv.backgroundColor = [UIColor colorWithHexString:@"E8E9EA"];
        [btn addSubview:lv];
        [self.btnArray addObject:btn];
    }
    [self addSubview:view];
    
}

#pragma mark -- 私有方法

#pragma mark -- 配置oneTB 的header
-(UIView *)setupOneTB_Head{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 51)];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 60, 15)];
    l.textAlignment = NSTextAlignmentCenter;
    l.font = [UIFont systemFontOfSize:14];
//    l.backgroundColor = [UIColor whiteColor];
    l.text = @"全部分类";
    l.textColor = [UIColor colorWithHexString:@"393939"];
    [v addSubview:l];
    UIView *lv = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH/2, 1)];
    lv.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    [v addSubview:lv];
    return v;
}


#pragma mark -- 初次拆分数据
-(void)splitData:(NSArray *)arr{
    if (_dropStyle == DropListLinkStyle) {
        NSDictionary *d;
        if (_index_one) {
            d = arr[_index_one];
        }else{
            d = arr[0];
        }
        [_oneDataArray removeAllObjects];
        [_twoDataArray removeAllObjects];
        int j = 0;
        for (NSDictionary *di in d[@"sub"]) {
            MenuModel *model = [[MenuModel alloc]init];
            model.titleStr = di[@"catname"];
            model.idStr = di[@"catid"];
            if (_index_two && j == _index_two) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
            [_twoDataArray addObject:model];
            j++;
        }
        
        int i = 0;
        for (NSDictionary *dic in arr) {
            MenuModel *model = [[MenuModel alloc]init];
            model.titleStr = dic[@"catname"];
            model.idStr = dic[@"catid"];
            if (i == _index_one) {
                model.isSelected = YES;;
            }else{
                model.isSelected = NO;
            }
            [_oneDataArray addObject:model];
            i++;
        }

    }else if (_dropStyle == DropListStyle){
        [_listArray removeAllObjects];
        int i = 0;
        for (NSDictionary *dic in arr) {
            MenuModel *model = [[MenuModel alloc]init];
            model.titleStr = dic[@"name"];
            model.idStr = dic[@"id"];
            if (_record_id == i) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
            [_listArray addObject:model];
            i++;
        }
    }else if (_dropStyle == DropCollectionStyle){
        [_listArray removeAllObjects];
        int i = 0;
        for (NSDictionary *dic in arr) {
            MenuModel *model = [[MenuModel alloc]init];
            model.titleStr = dic[@"areaname"];
            model.idStr = dic[@"areaid"];
            if (_record_id == i) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
            [_listArray addObject:model];
            i++;

        }
    }
}

/// 配置数据初始值
-(void)configData{
    
    CGFloat height = 0.0;
    switch (_dropStyle) {
        case DropListLinkStyle:
            /// 双排
            cellHeight = 51;
            CGFloat h1 = _oneDataArray.count*51;
            CGFloat h2 = _twoDataArray.count*51;
            height = h1>h2?h1:h2;
            break;
        case DropListStyle:
            /// 单排
            cellHeight = 50;
            height = _listArray.count*50;
            break;
        case DropCollectionStyle:
            cellHeight = 50;
            if (_listArray.count%kItemNum != 0) {
                height = (_listArray.count/kItemNum + 1)*50;
            }else{
                height = (_listArray.count/kItemNum)*50;
            }
            break;
        case DropDefaultStyle:
            
            break;
            
    }
    [self expandMenuWithHeight:height];
}


#pragma mark -- 展开
-(void)expandMenuWithHeight:(CGFloat)h{
    self.maskBackView.hidden = NO;
    CGRect rect = self.frame;
    rect.size.height = SCREEN_HEIGHT - 64 - 48;
    self.frame = rect;
    CGFloat tempH;
    if (rect.size.height-100 < h) {
        tempH = rect.size.height-100 ;
    }else{
        tempH = h;
    }
    [self showSpringAnimalWithDuration:.25 animations:^{
        if(_dropStyle == DropListLinkStyle){
            self.oneTableView.frame = CGRectMake(0, 44, SCREEN_WIDTH/4, tempH);
            self.twoCollectionView.frame = CGRectMake(SCREEN_WIDTH/4, 44, SCREEN_WIDTH*3/4, tempH);
        }else if (_dropStyle == DropListStyle){
            self.tableView.frame = CGRectMake(0, 44, SCREEN_WIDTH, tempH);
        }else if (_dropStyle == DropCollectionStyle){
            self.collectionView.frame = CGRectMake(0, 44, SCREEN_WIDTH, tempH);
        }
        
        _maskBackView.alpha = 1;

    } completion:^{
    }];
    
}

#pragma mark -- 收回
-(void)takeMenuBack{
    self.v_h = 44;
    for (UIButton *button in self.btnArray) {
        button.selected=NO;
    }
    
    [self showSpringAnimalWithDuration:.25 animations:^{
        if(_dropStyle == DropListLinkStyle){
            self.oneTableView.frame = CGRectMake(0, 44, SCREEN_WIDTH/4, 0);
            self.twoCollectionView.frame = CGRectMake(SCREEN_WIDTH/4, 44, SCREEN_WIDTH*3/4, 0);
            
        }else if (_dropStyle == DropListStyle){
            self.tableView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 0);
        }else if (_dropStyle == DropCollectionStyle){
            self.collectionView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 0);
        }
        _maskBackView.alpha = 0;
    } completion:^{
        _maskBackView.hidden = YES;
    }];
}

#pragma mark -- 弹簧效果
-(void)showSpringAnimalWithDuration:(CGFloat )duration animations:(void(^)())animation completion:(void(^)())complemation {
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (animation) {
            animation();
        }
    } completion:^(BOOL finished) {
        if (complemation) {
            complemation();
        }
    }];
    
}

#pragma mark -- 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _oneTableView) {
        return _oneDataArray.count;
    }else{
        return _listArray.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _oneTableView) {
        OneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
        MenuModel *model = _oneDataArray[indexPath.row];
        if (model.isSelected) {
            cell.tipView.hidden = NO;
            cell.backgroundColor = [UIColor whiteColor];
            cell.desLabel.textColor = kMenuCellSelectedColor;
            cell.desLabel.text = model.titleStr;
        }else{
            cell.tipView.hidden = YES;
            cell.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
            cell.desLabel.textColor = [UIColor colorWithHexString:@"393939"];
            cell.desLabel.text = model.titleStr;
        }
        return cell;
    }else{
        ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
        MenuModel *model = _listArray[indexPath.row];
        if (model.isSelected) {
            cell.tipImgView.hidden = NO;
            cell.desLabel.textColor = kMenuCellSelectedColor;
        }else{
            cell.tipImgView.hidden = YES;
            cell.desLabel.textColor = [UIColor colorWithHexString:@"05090D"];
        }
        cell.desLabel.text = model.titleStr;
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_dropStyle == DropListLinkStyle) {
        if (tableView == _oneTableView) {
            for (MenuModel *model in _oneDataArray) {
                model.isSelected = NO;
                
            }
            _index_one = indexPath.row;
            MenuModel *model = _oneDataArray[indexPath.row];
            model.isSelected = YES;
            
            [_twoDataArray removeAllObjects];
            NSDictionary *dic = _dataDict[@"data"][indexPath.row];
            for (NSDictionary *dic1 in dic[@"sub"]) {
                MenuModel *tm = [[MenuModel alloc]init];
                tm.titleStr = dic1[@"catname"];
                tm.idStr = dic1[@"catid"];
                tm.isSelected = NO;
                [_twoDataArray addObject:tm];
            }
            [_oneTableView reloadData];
            [_twoCollectionView reloadData];
        }
        
    }else if (_dropStyle == DropListStyle){
        /// 单排模式
        for (MenuModel *model in _listArray) {
            model.isSelected = NO;
        }
        
        MenuModel *model = _listArray[indexPath.row];
        [self.tempBtn setTitle:model.titleStr forState:UIControlStateNormal];

        model.isSelected = YES;
        [_tableView reloadData];
        NSString *str;
        
        if (model.idStr == nil) {
            str = @"";
        }else{
            str = model.idStr;
        }
        
        if (self.tempBtn.tag == 11) {
            _one_record_id = indexPath.row;
        }else if (self.tempBtn.tag == 12){
            _two_record_id = indexPath.row;
        }else if (self.tempBtn.tag == 13){
            _three_record_id = indexPath.row;
        }
        
        _tapClickCellBlock(model.titleStr,str,indexPath.row,self.tempBtn.tag);
        [self takeMenuBack];
    }
    [self.tempBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:1];

}





-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _collectionView) {
        return _listArray.count;
    }else if (collectionView == _twoCollectionView){
        return _twoDataArray.count;
    }else{
        return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _collectionView) {
        CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
        MenuModel *model = _listArray[indexPath.row];
        if (model.isSelected) {
            cell.desLabel.textColor = kMenuCellSelectedColor;
            cell.backgroundColor = kMenuCellSeletedBGColor;
        }else{
            cell.desLabel.textColor = [UIColor colorWithHexString:@"5A5B5C"];
            cell.backgroundColor = [UIColor whiteColor];
        }
        cell.desLabel.text = model.titleStr;
        
        return cell;
    }else{
        TwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"twoCell" forIndexPath:indexPath];
        MenuModel *model = _twoDataArray[indexPath.row];
        if (model.isSelected) {
            cell.desLabel.textColor = kMenuCellSelectedColor;
            cell.backgroundColor = kMenuCellSeletedBGColor;
        }else{
            cell.desLabel.textColor = [UIColor colorWithHexString:@"5A5B5C"];
            cell.backgroundColor = [UIColor whiteColor];
        }
        cell.desLabel.text = model.titleStr;
        
        return cell;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (collectionView == _twoCollectionView) {
        /// 完成
        MenuModel *model = _twoDataArray[indexPath.row];
        _index_two = indexPath.row;
        [self.tempBtn setTitle:model.titleStr forState:UIControlStateNormal];
        NSString *str;
        if (model.idStr == nil) {
            str = @"";
        }else{
            str = model.idStr;
        }
        _tapClickCellListBlock(model.titleStr,str,_index_one,_index_two);
//        _tapClickCellBlock(model.titleStr,str,_tempBtn.tag-10);
        [self takeMenuBack];
    }else{
        for (MenuModel *model in _listArray) {
            model.isSelected = NO;
        }
        
        MenuModel *model = _listArray[indexPath.row];
        [self.tempBtn setTitle:model.titleStr forState:UIControlStateNormal];
        model.isSelected = YES;
        
        [_collectionView reloadData];
        
        NSString *str;
        
        if (model.idStr == nil) {
            str = @"";
        }else{
            str = model.idStr;
        }
        if (self.tempBtn.tag == 11) {
            _one_record_id = indexPath.row;
        }else if (self.tempBtn.tag == 12){
            _two_record_id = indexPath.row;
        }else if (self.tempBtn.tag == 13){
            _three_record_id = indexPath.row;
        }
        _tapClickCellBlock(model.titleStr,str,indexPath.row,self.tempBtn.tag);
        [self.tempBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:1];
        
        [self takeMenuBack];

    }
    [self.tempBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:1];

}


#pragma mark -- 响应事件

#pragma mark -- 点击
-(void)topButtonClick:(UIButton *)button{
    self.tempBtn = button;
    for (UIButton *tb in _btnArray) {
        if (button == tb) {
            tb.selected = !tb.selected;
        }else{
            tb.selected = NO;
        }
    }
    if (self.tempBtn.tag == 11) {
        _record_id = _one_record_id;
    }else if (self.tempBtn.tag == 12){
        _record_id = _two_record_id;
    }else if (self.tempBtn.tag == 13){
        _record_id = _three_record_id;
    }
    if (button.selected) {
        /// 对数据进行拆分
        NSDictionary *dic = _dataArray[button.tag-10];
        if (dic == nil) {
            return;
        }
        self.dropStyle = [dic[@"dropStyle"] integerValue];
        _dataDict = dic;
        
        _oneTableView.hidden = YES;
        _twoCollectionView.hidden = YES;
        _collectionView.hidden = YES;
        _tableView.hidden = YES;
        
        if (_dropStyle == DropListStyle) {
            /// 单排列表模式
            /// 移除除了自己的以外试图
            
            _tableView.hidden = NO;
            [_tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
            _tableView.rowHeight = 50;
            [self splitData:dic[@"data"]];
            [self configData];
            [self.tableView reloadData];

        }else if (_dropStyle == DropListLinkStyle){
            /// 两排列表模式
            _oneTableView.hidden = NO;
            _twoCollectionView.hidden = NO;
            [_oneTableView registerNib:[UINib nibWithNibName:@"OneCell" bundle:nil] forCellReuseIdentifier:@"oneCell"];
            _oneTableView.sectionHeaderHeight = 51;
            _oneTableView.rowHeight = 51;
//            _oneTableView.tableHeaderView = [self setupOneTB_Head];

            [_twoCollectionView registerNib:[UINib nibWithNibName:@"TwoCell" bundle:nil] forCellWithReuseIdentifier:@"twoCell"];
        
            [self splitData:dic[@"data"]];
            [self configData];
            
            [self.oneTableView reloadData];
            [self.twoCollectionView reloadData];
            [_oneTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];

            
        }else if (_dropStyle == DropCollectionStyle){
            /// collection 模式
            self.collectionView.hidden = NO;
            
            [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
            [self splitData:dic[@"data"]];
            [self configData];
            [self.collectionView reloadData];
            
        }else{
            /// 默认模式
            
            
            
            
        }
        
        
        
    }else{
        [self takeMenuBack];
    }
   
}


#pragma mark -- 点击蒙版
-(void)maskBackGroundViewTapClick{
    [self takeMenuBack];
}




#pragma mark -- setter
-(UIView *)maskBackView{
    if (_maskBackView) {
        return _maskBackView;
    }
    _maskBackView=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width, SCREEN_HEIGHT - self.frame.origin.y)];
    _maskBackView.backgroundColor=[UIColor colorWithRed:40/255 green:40/255 blue:40/255 alpha:.2];
    _maskBackView.hidden=YES;
    _maskBackView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskBackGroundViewTapClick)];
    [_maskBackView addGestureRecognizer:tap];
    
    
    return _maskBackView;

    
}


-(UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator = NO;
    return _tableView;
}

-(UITableView *)oneTableView{
    if (_oneTableView) {
        return _oneTableView;
    }
    _oneTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, 0) style:UITableViewStylePlain];
    _oneTableView.delegate = self;
    _oneTableView.dataSource = self;
    _oneTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _oneTableView.showsHorizontalScrollIndicator = NO;
    return _oneTableView;
}

-(UICollectionView *)twoCollectionView{
    if (_twoCollectionView) {
        return _twoCollectionView;
    }
    _twoLayout = [[UICollectionViewFlowLayout alloc]init];
    itemW = (SCREEN_WIDTH*3/4-30)/3;
    itemH = 25;
    _twoLayout.itemSize = CGSizeMake(itemW, itemH);
    _twoLayout.minimumInteritemSpacing = 5;
    _twoLayout.sectionInset = UIEdgeInsetsMake(10, 5, 0, 0);
    _twoLayout.minimumLineSpacing = 20;
    _twoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH*3/4, 0) collectionViewLayout:_twoLayout];
    _twoCollectionView.backgroundColor = [UIColor whiteColor];
    _twoCollectionView.delegate = self;
    _twoCollectionView.dataSource = self;
    _twoCollectionView.showsHorizontalScrollIndicator = NO;
    return _twoCollectionView;
}


-(UICollectionView *)collectionView{
    if (_collectionView) {
        return _collectionView;
    }
    
    _layout = [[UICollectionViewFlowLayout alloc]init];
    itemW = SCREEN_WIDTH/4;
    itemH = 50;
    _layout.itemSize = CGSizeMake(itemW, itemH);
    _layout.minimumInteritemSpacing = 0;
    _layout.minimumLineSpacing = 0; //上下的间距 可以设置0看下效果
    
//    _layout.headerReferenceSize=CGSizeMake(self.frame.size.width, 30); //设置collectionView头视图的大小
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 0) collectionViewLayout:_layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    
    return self.collectionView;
}




@end
