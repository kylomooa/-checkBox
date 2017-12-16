//
//  LevelTwoTableView.m
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import "LevelTwoTableView.h"
#import "LevelTwoHeaderView.h"
#import "LevelThreeCell.h"

@interface LevelTwoTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LevelTwoTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource =self;
        self.showsVerticalScrollIndicator = YES;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.scrollEnabled = NO;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelLevelTwoArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CheckBoxItemModel *modelLevelTwo = self.modelLevelTwoArray[section];
    //每组section只存在两个cell，row = 0 为第二级cell，row = 1为第三级cell
    if (modelLevelTwo && modelLevelTwo.childCheckItems.count == 0 ) {
        return 1;
    }else{
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckBoxItemModel *modelLevelTwo = self.modelLevelTwoArray[indexPath.section];
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        LevelTwoHeaderView *header = [[LevelTwoHeaderView alloc]init];
        header.modelLevelTwo = modelLevelTwo;
        
        header.didClickHeadr = ^(BOOL isOpen, NSInteger checkItem) {
            if (weakSelf.didClickLevelTwoHead) {
                weakSelf.didClickLevelTwoHead(isOpen,checkItem);
            }
        };
        
        header.didClickCheckBoxBtnLevelTwo = ^(BOOL isChecked, NSInteger checkItem) {
            if (weakSelf.didClickCheckBoxBtnLevelTwo) {
                weakSelf.didClickCheckBoxBtnLevelTwo(isChecked,checkItem);
            }
        };
        
        header.selectionStyle = UITableViewCellSelectionStyleNone;
        return header;
    }else{
        LevelThreeCell *cell = [[LevelThreeCell alloc] init];
        cell.didClickCheckBoxBtnLevelThree = ^(BOOL isChecked, NSInteger checkItem) {
            if (weakSelf.didClickCheckBoxBtnLevelThree) {
                weakSelf.didClickCheckBoxBtnLevelThree(isChecked,checkItem);
            }
        };
        
        cell.modelLevelTwo = modelLevelTwo;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第二级cell
    if (indexPath.row == 0) {
        return levelTwoCellHeight;
    }else if (indexPath.row == 1){
        CheckBoxItemModel *modelLevelTwo = self.modelLevelTwoArray[indexPath.section];
        if (modelLevelTwo.childCheckItems.count != 0 && modelLevelTwo.isOpen) {
            return modelLevelTwo.childCheckItems.count * levelThreeCellHeight;
        }else{
            return 0;
        }
    }
    return 0;
}

-(void)setModelLevelTwoArray:(NSArray *)modelLevelTwoArray{
    _modelLevelTwoArray = modelLevelTwoArray;
    [self reloadData];
}
@end
