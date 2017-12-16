//
//  LevelOneHeaderView.m
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import "LevelOneHeaderView.h"

@interface LevelOneHeaderView()
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UIImageView *arrowImage;

@end

@implementation LevelOneHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickSelf)];
        [self addGestureRecognizer:tap];
        
        self.contentView.backgroundColor = WEBRBGCOLOR(0xf1f1f1);
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.arrowImage];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.centerY);
        make.left.equalTo(self.contentView.left).offset(17);
    }];
    
    [self.arrowImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.centerY);
        make.right.equalTo(self.contentView.right).offset(-10);
    }];
    
}

-(void)didClickSelf{
    if (self.didClickHeadr) {
        self.didClickHeadr(!self.modelLevelOne.isOpen);
    }
}

-(UIImageView *)arrowImage{
    if (nil == _arrowImage) {
        _arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"close"]];
    }
    return _arrowImage;
}

-(UILabel *)title{
    if (nil == _title) {
        _title = [[UILabel alloc]init];
        _title.textColor = WEBRBGCOLOR(0x4B96DC);
        _title.font = [UIFont systemFontOfSize:19];
    }
    return _title;
}

-(void)setModelLevelOne:(CheckBoxItemModel *)modelLevelOne{
    _modelLevelOne = modelLevelOne;
    self.arrowImage.image = [UIImage imageNamed:(modelLevelOne.isOpen ? @"open" : @"close")];
    self.title.text = [NSString stringWithFormat:@"第一层级(checkItemId=%ld)",modelLevelOne.checkItemId];

}

@end
