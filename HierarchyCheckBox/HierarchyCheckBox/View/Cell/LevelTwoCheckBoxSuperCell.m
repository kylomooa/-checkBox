//
//  LevelTwoCheckBoxSuperCell.m
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import "LevelTwoCheckBoxSuperCell.h"
#import "LevelTwoTableView.h"

@interface LevelTwoCheckBoxSuperCell()
@property (nonatomic, strong) LevelTwoTableView *tableView;
@end

@implementation LevelTwoCheckBoxSuperCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModelLevelOne:(CheckBoxItemModel *)modelLevelOne{
    _modelLevelOne = modelLevelOne;
    
    //如果未展开第二级 则隐藏cell
    self.hidden = !modelLevelOne.isOpen;
    self.tableView.modelLevelTwoArray = modelLevelOne.childCheckItems;
}

-(LevelTwoTableView *)tableView{
    if (nil == _tableView) {
        _tableView = [[LevelTwoTableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.tableView];
        __weak typeof(self) weakSelf = self;
        
        [self.tableView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.left);
            make.top.equalTo(self.contentView.top);
            make.right.equalTo(self.contentView.right);
            make.bottom.equalTo(self.contentView.bottom);
        }];
        
        self.tableView.didClickCheckBoxBtnLevelThree = ^(BOOL isChecked, NSInteger checkItem) {
            if (weakSelf.didClickCheckBoxBtnLevelThree) {
                weakSelf.didClickCheckBoxBtnLevelThree(isChecked,checkItem);
            }
        };
        
        self.tableView.didClickCheckBoxBtnLevelTwo= ^(BOOL isChecked, NSInteger checkItem) {
            if (weakSelf.didClickCheckBoxBtnLevelTwo) {
                weakSelf.didClickCheckBoxBtnLevelTwo(isChecked,checkItem);
            }
        };
        
        self.tableView.didClickLevelTwoHead = ^(BOOL isOpen, NSInteger checkItem) {
            if (weakSelf.didClickLevelTwoHead) {
                weakSelf.didClickLevelTwoHead(isOpen, checkItem);
            }
        };
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
