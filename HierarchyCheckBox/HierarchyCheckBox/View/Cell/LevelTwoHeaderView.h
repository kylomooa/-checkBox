//
//  LevelTwoHeaderView.h
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckBoxItemModel.h"

typedef void(^didClickHeadr)(BOOL isOpen,NSInteger checkItem);
typedef void(^didClickCheckBoxBtnLevelTwo)(BOOL isChecked, NSInteger checkItem);

@interface LevelTwoHeaderView : UITableViewCell
@property (nonatomic, strong) CheckBoxItemModel *modelLevelTwo;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, copy) didClickHeadr didClickHeadr;
@property (nonatomic, copy) didClickCheckBoxBtnLevelTwo didClickCheckBoxBtnLevelTwo;
@property (nonatomic,strong) UIImageView *checkBoxImage;
@end
