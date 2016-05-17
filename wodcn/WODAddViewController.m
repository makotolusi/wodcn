//
//  WODAddViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/12.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODAddViewController.h"
#import "WODKeyBoardToolBar.h"

@interface WODAddViewController ()<WODKeyBoardToolBarDelegate,UITextFieldDelegate>
{
    
    WODKeyBoardToolBar* wodKeyboardtoolbar;
    WODKeyBoardToolBar* wodpickerdone;
}
@end

@implementation WODAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    wodKeyboardtoolbar=[[WODKeyBoardToolBar alloc] init];
    wodKeyboardtoolbar.wodToolbarDelegate=self;
    
    wodpickerdone=[[WODKeyBoardToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,  SCREEN_HEIGHT*0.3)];
    wodpickerdone.wodToolbarDelegate=self;
    
    self.wodType= [[WODTypePicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.3) Data:[NSArray arrayWithObjects:@"For Time",@"For Count",@"For XXX",@"For Sex", nil]];
    [self.view addSubview:self.wodType];
    
    self.wodTypeLabel.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popView:)];
    
    [self.wodTypeLabel addGestureRecognizer:labelTapGestureRecognizer];
    
    //定义一个toolBar
    wodKeyboardtoolbar.frame=CGRectMake(0, 0, SCREEN_WIDTH, 30);
    [self.wodTextArea setInputAccessoryView:wodKeyboardtoolbar];
    
    
}

-(void)off{

    if ([self.wodTextArea isFirstResponder]) {
        [self.wodTextArea resignFirstResponder];
    }else
        [self inView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)popView:(UITapGestureRecognizer *)recognizer{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    self.wodType.frame = CGRectMake(0, SCREEN_HEIGHT-SCREEN_HEIGHT*0.3, SCREEN_WIDTH, SCREEN_HEIGHT*0.3);
   
    wodpickerdone.frame =CGRectMake(0, self.wodType.frame.origin.y, SCREEN_WIDTH, 30);
    [self.view addSubview:wodpickerdone];
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
//    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}

- (void)inView{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    self.wodType.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.3);
    wodpickerdone.frame =CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 30);
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
//    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}



@end
