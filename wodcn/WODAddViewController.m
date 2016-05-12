//
//  WODAddViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/12.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODAddViewController.h"

@interface WODAddViewController ()<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>
{
    NSArray *pickerArray;
}
@end

@implementation WODAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wodType= [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    pickerArray = [NSArray arrayWithObjects:@"For Time",@"For Count",@"For XXX",@"For Sex", nil];
//    textField.inputView = selectPicker;
//    textField.inputAccessoryView = doneToolbar;
//    textField.delegate = self;
    self.wodType.delegate = self;
    self.wodType.dataSource = self;
    [self.view addSubview:self.wodType];
    
    self.wodTypeLabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popView:)];
    
    [self.wodTypeLabel addGestureRecognizer:labelTapGestureRecognizer];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger row = [self.wodType selectedRowInComponent:0];
//    self.textField.text = [pickerArray objectAtIndex:row];
}

- (void)popView:(UITapGestureRecognizer *)recognizer{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    self.wodType.frame = CGRectMake(0, SCREEN_HEIGHT-self.wodType.frame.size.height-30, SCREEN_WIDTH, self.wodType.frame.size.height);
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}

@end
