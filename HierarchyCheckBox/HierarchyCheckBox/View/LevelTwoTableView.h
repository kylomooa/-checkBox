//
//  LevelTwoTableView.h
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckBoxItemModel.h"

typedef void(^didClickLevelTwoHead)(BOOL isOpen,NSInteger checkItem);
typedef void(^didClickCheckBoxBtnLevelTwo)(BOOL isChecked, NSInteger checkItem);
typedef void(^didClickCheckBoxBtnLevelThree)(BOOL isChecked, NSInteger checkItem);

@interface LevelTwoTableView : UITableView
@property (nonatomic, copy) didClickLevelTwoHead didClickLevelTwoHead;
@property (nonatomic, copy) didClickCheckBoxBtnLevelTwo didClickCheckBoxBtnLevelTwo;
@property (nonatomic, copy) didClickCheckBoxBtnLevelThree didClickCheckBoxBtnLevelThree;

@property (nonatomic, strong) NSArray *modelLevelTwoArray;

@end
