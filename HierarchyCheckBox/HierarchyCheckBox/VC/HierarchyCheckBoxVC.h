//
//  HierarchyCheckBoxVC.h
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HierarchyCheckBoxVC : UIViewController
@property (nonatomic, assign) BOOL checkBoxRelated; //默认开启第二级checkBox和第三级checkBox联动，如果第二级勾选框选择，那么第三级勾选框必选中至少一个，反之亦然。
@end
