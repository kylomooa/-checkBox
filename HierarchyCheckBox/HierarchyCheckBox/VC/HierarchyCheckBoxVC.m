//
//  HierarchyCheckBoxVC.m
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import "HierarchyCheckBoxVC.h"
#import "CheckBoxItemModel.h"

#import "LevelOneHeaderView.h"
#import "LevelTwoCheckBoxSuperCell.h"
#import "LevelTwoTableView.h"

@interface HierarchyCheckBoxVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HierarchyCheckBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"层级选择checkBox";
    self.checkBoxRelated = YES;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第一级model
    CheckBoxItemModel *modelLevelOne = self.dataArray[indexPath.section];
    
    __block CGFloat height = 0;
    //是否展开第二级
    if (modelLevelOne.isOpen) {
        [modelLevelOne.childCheckItems enumerateObjectsUsingBlock:^(CheckBoxItemModel *modelLevelTwo, NSUInteger idx, BOOL * _Nonnull stop) {
            //是否展开第三级
            if (modelLevelTwo.isOpen) {
                height += modelLevelTwo.childCheckItems.count *levelThreeCellHeight;
            }
            height += levelTwoCellHeight;
        }];
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LevelTwoCheckBoxSuperCell *cell = [[LevelTwoCheckBoxSuperCell alloc] init];
    
    //第一级model
    CheckBoxItemModel *modelLevelOne = self.dataArray[indexPath.section];
    
    cell.modelLevelOne = modelLevelOne;
    
    __weak typeof(self) weakSelf = self;
    
    //点击第二级cell时 展开/收缩
    cell.didClickLevelTwoHead = ^(BOOL isOpen,NSInteger checkItem) {
        
        [modelLevelOne.childCheckItems enumerateObjectsUsingBlock:^(CheckBoxItemModel *modelLevelTwo, NSUInteger idx, BOOL * _Nonnull stop) {
            if (checkItem == modelLevelTwo.checkItemId) {
                modelLevelTwo.isOpen = isOpen;
            }
        }];
        
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    //点击第二级checkBoxItem 选中/取消选择
    cell.didClickCheckBoxBtnLevelTwo = ^(BOOL isChecked, NSInteger checkItem) {
        [modelLevelOne.childCheckItems enumerateObjectsUsingBlock:^(CheckBoxItemModel *modelLevelTwo, NSUInteger idx, BOOL * _Nonnull stop) {
            if (checkItem == modelLevelTwo.checkItemId) {
                modelLevelTwo.isChecked = isChecked;
                
                //第三级checkBox跟随第二级checkBox联动(可关闭)
                if (self.checkBoxRelated) {
                    [modelLevelTwo.childCheckItems enumerateObjectsUsingBlock:^(CheckBoxItemModel *modelLevelThree, NSUInteger idx, BOOL * _Nonnull stop) {
                        modelLevelThree.isChecked = isChecked;
                    }];
                }
            }
        }];
        
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    //点击第三级checkBoxItem 选中/取消选择
    cell.didClickCheckBoxBtnLevelThree = ^(BOOL isChecked, NSInteger checkItem) {
        
        [modelLevelOne.childCheckItems enumerateObjectsUsingBlock:^(CheckBoxItemModel *modelLevelTwo, NSUInteger idx, BOOL * _Nonnull stop) {
            [modelLevelTwo.childCheckItems enumerateObjectsUsingBlock:^(CheckBoxItemModel *modelLevelThree, NSUInteger idx, BOOL * _Nonnull stop) {
                if (checkItem == modelLevelThree.checkItemId) {
                    modelLevelThree.isChecked = isChecked;
                    
                    //第二级checkBox跟随第三级checkBox联动 (可关闭)
                    if (self.checkBoxRelated) {
                        BOOL isExistCheckedInLevelThree = NO;
                        for (CheckBoxItemModel *model in modelLevelTwo.childCheckItems) {
                            if (model.isChecked) {
                                isExistCheckedInLevelThree = YES;
                            }
                        }
                        modelLevelTwo.isChecked = isExistCheckedInLevelThree;
                    }
                }
            }];
        }];
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return levelOneCellHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    LevelOneHeaderView *header = [[LevelOneHeaderView alloc]init];
    
    //第一级model
    CheckBoxItemModel *modelLevelOne = self.dataArray[section];
    header.modelLevelOne = modelLevelOne;
    __weak typeof(self) weakSelf = self;
    header.didClickHeadr = ^(BOOL isOpen) {
        
        modelLevelOne.isOpen = isOpen;
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return header;
    
}
-(NSMutableArray *)dataArray{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
        
        NSArray *array = @[
                           @{
                               @"checkItemId":@(1),
                               @"isChecked":@(YES),
                               @"isOpen":@(YES),
                               @"childCheckItems":@[
                                                    @{
                                                        @"checkItemId":@(10),
                                                        @"isChecked":@(YES),
                                                        @"isOpen":@(YES),
                                                        @"childCheckItems":@[
                                                                @{
                                                                    @"checkItemId":@(100),
                                                                    @"isChecked":@(YES),
                                                                    @"isOpen":@(YES)
                                                                    },
                                                                @{
                                                                    @"checkItemId":@(101),
                                                                    @"isChecked":@(YES),
                                                                    @"isOpen":@(YES)
                                                                    }
                                                                ]
                                                      },
                                                    @{
                                                        @"checkItemId":@(11),
                                                        @"isChecked":@(YES),
                                                        @"isOpen":@(YES),
                                                        @"childCheckItems":@[
                                                                @{
                                                                    @"checkItemId":@(110),
                                                                    @"isChecked":@(YES),
                                                                    @"isOpen":@(YES)
                                                                    },
                                                                @{
                                                                    @"checkItemId":@(111),
                                                                    @"isChecked":@(YES),
                                                                    @"isOpen":@(YES)
                                                                    }
                                                                ]
                                                    }
                                                ]
                             
                             },
                           @{
                               @"checkItemId":@(2),
                               @"isChecked":@(YES),
                               @"isOpen":@(YES),
                               @"childCheckItems":@[
                                       @{
                                           @"checkItemId":@(20),
                                           @"isChecked":@(YES),
                                           @"isOpen":@(YES),
                                           @"childCheckItems":@[
                                                   @{
                                                       @"checkItemId":@(200),
                                                       @"isChecked":@(YES),
                                                       @"isOpen":@(YES)
                                                       },
                                                   @{
                                                       @"checkItemId":@(201),
                                                       @"isChecked":@(YES),
                                                       @"isOpen":@(YES)
                                                       }
                                                   ]
                                           },
                                       @{
                                           @"checkItemId":@(21),
                                           @"isChecked":@(YES),
                                           @"isOpen":@(YES),
                                           @"childCheckItems":@[
                                                   @{
                                                       @"checkItemId":@(210),
                                                       @"isChecked":@(YES),
                                                       @"isOpen":@(YES)
                                                       },
                                                   @{
                                                       @"checkItemId":@(211),
                                                       @"isChecked":@(YES),
                                                       @"isOpen":@(YES)
                                                       }
                                                   ]
                                           }
                                       ]
                               
                               }
                       ];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            CheckBoxItemModel *model = [CheckBoxItemModel CheckBoxItemModelWihtDict:dict];
            [_dataArray addObject:model];
        }];
    }
    return _dataArray;
}
@end
