//
//  LevelOneHeaderView.h
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckBoxItemModel.h"


typedef void(^didClickHeadr)(BOOL isOpen);

@interface LevelOneHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) CheckBoxItemModel *modelLevelOne;
@property (nonatomic, copy) didClickHeadr didClickHeadr;
@end
