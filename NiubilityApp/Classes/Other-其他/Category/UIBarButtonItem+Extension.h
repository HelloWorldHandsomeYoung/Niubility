//
//  UIBarButtonItem+Extension.h
//  NiubilityApp
//
//  Created by 吕阳 on 16/3/8.
//  Copyright © 2016年 DeveloperYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
@end
