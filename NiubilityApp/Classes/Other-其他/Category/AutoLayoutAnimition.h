//
//  AutoLayoutAnimition.h
//  NiubilityApp
//
//  Created by 吕阳 on 16/3/5.
//  Copyright © 2016年 DeveloperYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoLayoutAnimition : NSObject

+ (void)thirdLogin:(UIView *)button withView:(UIView *)view withTimeInterval:(NSTimeInterval )time;

+ (void)loginButtonMaskAnimition:(UIView *)view withBeginTime:(NSTimeInterval)time;

+ (void)midToSide:(NSLayoutConstraint *)constrains withView:(UIView *)View;

+ (void)topLabelWith:(UILabel *)label withView:(UIView *)view;

+ (void)backZeroLayoutConstraint:(NSLayoutConstraint *)constrains withView:(UIView *)view;
@end
