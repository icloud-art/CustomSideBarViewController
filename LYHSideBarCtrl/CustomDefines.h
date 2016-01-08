//
//  CustomDefines.h
//  LYHSideBarCtrl
//
//  Created by Charles on 16/1/8.
//  Copyright © 2016年 Charles Leo. All rights reserved.
//

#ifndef CustomDefines_h
#define CustomDefines_h

/**
 *  屏幕宽度
 */
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

/**
 *  屏幕高度
 */

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

/**
 *  SideBar偏移量
 */
#define ContentOffset SCREENWIDTH / 6 * 5 - 10

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  背景色
 */
#define bgViewColor UIColorFromRGB(0xf5f5f5)

#define customerBgColor [UIColor colorWithRed:243.0/255.0f green:243.0/255.0f blue:243.0/255.0f alpha:1]

#define customerBlue [UIColor colorWithRed:2.0/255.0f green:188.0/255.0f blue:250.0/255.0f alpha:1]

#endif /* CustomDefines_h */
