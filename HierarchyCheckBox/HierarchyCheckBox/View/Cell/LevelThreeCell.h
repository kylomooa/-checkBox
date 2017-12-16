//
//  LevelThreeCell.h
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/16.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckBoxItemModel.h"

typedef void(^didClickCheckBoxBtnLevelThree)(BOOL isChecked, NSInteger checkItem);

@interface LevelThreeCell : UITableViewCell

@property (nonatomic, copy) didClickCheckBoxBtnLevelThree didClickCheckBoxBtnLevelThree;
@property (nonatomic, strong) CheckBoxItemModel *modelLevelTwo;
@end
