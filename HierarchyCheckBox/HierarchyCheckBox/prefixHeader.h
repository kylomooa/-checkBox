//
//  prefixHeader.h
//  HierarchyCheckBox
//
//  Created by maoqiang on 2017/12/15.
//  Copyright © 2017年 kylo.mooa. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#ifndef prefixHeader_h
#define prefixHeader_h

#import "Masonry.h"


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define levelOneCellHeight 60
#define levelTwoCellHeight 40
#define levelThreeCellHeight 40

#define WEBRBGCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0  green:((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* prefixHeader_h */
