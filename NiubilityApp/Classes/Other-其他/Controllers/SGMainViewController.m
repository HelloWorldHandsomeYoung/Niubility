//
//  SGMainViewController.m
//  NiubilityApp
//
//  Created by 王辉 on 16/3/1.
//  Copyright © 2016年 DeveloperYoung. All rights reserved.
//

#import "SGMainViewController.h"
#import "SGLoginViewController.h"
#import "SGRegisterController.h"
#import "SGViewController.h"
#import "AutoLayoutAnimition.h"

@interface SGMainViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;

@end

@implementation SGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.lineWidth.constant = 0;
    self.imageWidth.constant = 0;
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [AutoLayoutAnimition midToSide:self.imageWidth withView:self.view];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
