//
//  LevelThreeCell.m
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/16.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import "LevelThreeCell.h"
#import "HCUbtton.h"

@implementation LevelThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModelLevelTwo:(CheckBoxItemModel *)modelLevelTwo{
    _modelLevelTwo = modelLevelTwo;
    //如果未展开第三级 则隐藏cell
    self.hidden = !modelLevelTwo.isOpen;

    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag >= 5000) {
            [obj removeFromSuperview];
        }
    }];
    
    [modelLevelTwo.childCheckItems enumerateObjectsUsingBlock:^(CheckBoxItemModel *modelLevelThree, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = 7000 + idx;
        imageView.userInteractionEnabled = YES;
        HCUbtton *checkBoxBtn = [[HCUbtton alloc]init];
        checkBoxBtn.isChecked = modelLevelThree.isChecked;
        checkBoxBtn.btnId = modelLevelThree.checkItemId;
        
        imageView.image = [UIImage imageNamed:checkBoxBtn.isChecked ? @"check_selecter" : @"check_unselecter"];
        
        checkBoxBtn.tag = 6000 + idx;
        checkBoxBtn.userInteractionEnabled = YES;
        [checkBoxBtn addTarget:self action:@selector(didClickCheckBox:) forControlEvents:UIControlEventTouchUpInside];

        UILabel *label =  [[UILabel alloc]init];
        label.tag = 5000 + idx;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = WEBRBGCOLOR(0x797979);
        label.text = [NSString stringWithFormat:@"第三级(checkItemId=%ld)",modelLevelThree.checkItemId];
        [self.contentView addSubview:label];
        [self.contentView addSubview:imageView];
        [self.contentView addSubview:checkBoxBtn];
        
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left).offset(60);
            make.centerY.equalTo(label.centerY);
            make.width.equalTo(levelTwoCellHeight * 0.4);
            make.height.equalTo(levelTwoCellHeight * 0.4);
        }];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.right).offset(8);
            make.top.equalTo(self.top).offset(levelThreeCellHeight * idx);
            make.height.equalTo(levelThreeCellHeight);
        }];
        
        [checkBoxBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.left);
            make.centerY.equalTo(label.centerY);
            make.width.equalTo(label.width);
            make.height.equalTo(levelThreeCellHeight);
        }];
    }];
}

-(void)didClickCheckBox:(HCUbtton *)checkBoxBtn{
    if (self.didClickCheckBoxBtnLevelThree) {
        self.didClickCheckBoxBtnLevelThree(!checkBoxBtn.isChecked, checkBoxBtn.btnId);
    }
}

@end
