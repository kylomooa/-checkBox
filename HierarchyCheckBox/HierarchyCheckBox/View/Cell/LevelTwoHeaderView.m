//
//  LevelTwoHeaderView.m
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//

#import "LevelTwoHeaderView.h"

@interface LevelTwoHeaderView()
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UIImageView *arrowImage;
@property (nonatomic,strong) UIButton *btn;

@end

@implementation LevelTwoHeaderView

-(UIButton *)btn{
    if (nil == _btn) {
        _btn = [[UIButton alloc]init];
        [_btn addTarget:self action:@selector(didClickCheckBox) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(void)setModelLevelTwo:(CheckBoxItemModel *)modelLevelTwo{
    _modelLevelTwo = modelLevelTwo;
    //没有第三级目录不显示"下剪头"
    self.arrowImage.hidden = modelLevelTwo.childCheckItems.count == 0 ? YES : NO;
    self.title.text = [NSString stringWithFormat:@"第二级(checkItemId=%ld)",modelLevelTwo.checkItemId];
    
    self.isOpen = modelLevelTwo.isOpen;
    self.isChecked = modelLevelTwo.isChecked;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.contentView.backgroundColor = WEBRBGCOLOR(0xf9f9f9);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickSelf)];
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.checkBoxImage];
    [self addSubview:self.title];
    [self addSubview:self.arrowImage];
    [self addSubview:self.btn];
    
    [self.checkBoxImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(30);
        make.width.equalTo(levelTwoCellHeight * 0.4);
        make.height.equalTo(levelTwoCellHeight * 0.4);
    }];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.checkBoxImage.right).offset(8);
    }];
    
    [self.arrowImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(self.right).offset(-30);
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkBoxImage.left);
        make.centerY.equalTo(self.checkBoxImage.centerY);
        make.width.equalTo(self.title.frame.size.width + self.checkBoxImage.frame.size.width);
        make.height.equalTo(levelTwoCellHeight);
    }];
}

-(void)didClickSelf{
    if (self.didClickHeadr) {
        //没有第三级目录时不展开cell
        if (self.modelLevelTwo.childCheckItems.count !=0 ) {
            self.isOpen = !self.isOpen;
            self.didClickHeadr(self.isOpen, self.modelLevelTwo.checkItemId);
        }
    }
}

-(void)didClickCheckBox{
    if (self.didClickCheckBoxBtnLevelTwo) {
        self.didClickCheckBoxBtnLevelTwo(!self.isChecked,self.modelLevelTwo.checkItemId);
    }
}

-(UIImageView *)arrowImage{
    if (nil == _arrowImage) {
        _arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"close"]];
    }
    return _arrowImage;
}

-(UIImageView *)checkBoxImage{
    if (nil == _checkBoxImage) {
        _checkBoxImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check_unselecter"]];
        _checkBoxImage.userInteractionEnabled = YES;
    }
    return _checkBoxImage;
}

-(UILabel *)title{
    if (nil == _title) {
        _title = [[UILabel alloc]init];
        _title.textColor = WEBRBGCOLOR(0x333333);
        _title.font = [UIFont systemFontOfSize:15];
    }
    return _title;
}

-(void)setIsChecked:(BOOL)isChecked{
    _isChecked = isChecked;
    if (_isChecked) {
        self.checkBoxImage.image = [UIImage imageNamed:@"check_selecter"];
    }else{
        self.checkBoxImage.image = [UIImage imageNamed:@"check_unselecter"];
    }
}

-(void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    if (isOpen) {
        self.arrowImage.image = [UIImage imageNamed:@"open"];
    }else{
        self.arrowImage.image = [UIImage imageNamed:@"close"];
    }
}

@end
