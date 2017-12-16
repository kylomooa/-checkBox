//
//  CheckBoxItemModel.h
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckBoxItemModel : NSObject
@property (nonatomic, assign) NSInteger checkItemId;
@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) NSArray *childCheckItems;

+(instancetype)CheckBoxItemModelWihtDict:(NSDictionary *)dict;
@end
