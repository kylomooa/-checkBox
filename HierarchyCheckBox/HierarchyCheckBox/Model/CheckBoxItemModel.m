//
//  CheckBoxItemModel.m
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import "CheckBoxItemModel.h"

@implementation CheckBoxItemModel

+(instancetype)CheckBoxItemModelWihtDict:(NSDictionary *)dict{
    CheckBoxItemModel *model = [[self alloc]init];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL * _Nonnull stop) {
        //最多做了两层解析
        if ([key isEqualToString:@"childCheckItems"]) {
            if (value) {
                NSArray *array = (NSArray *)value;
                NSMutableArray *emptyArrays= [NSMutableArray array];
                [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                    CheckBoxItemModel *childModel = [CheckBoxItemModel CheckBoxItemModelWihtDict:dict];
                    [emptyArrays addObject:childModel];
                }];
               [model setValue:emptyArrays forKey:key];
            }
        }else{
            [model setValue:value  forKey:key];
        }
    }];
    
    return model;
}
@end
