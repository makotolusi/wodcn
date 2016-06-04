//
//  WODTypePicker.m
//  wodcn
//
//  Created by 陆思 on 16/5/17.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODTypePicker.h"

@implementation WODTypePicker


- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray*)data
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerArray=data;
        self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.picker.dataSource=self;
        self.picker.delegate=self;
        self.picker.backgroundColor=[UIColor groupTableViewBackgroundColor];
        self.currentValue=self.pickerArray[0];
        [self addSubview:self.picker];
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickerArray objectAtIndex:row];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 30)];
        
        myView.text = [self.pickerArray objectAtIndex:row];
        
        myView.textAlignment = NSTextAlignmentCenter;
    
        myView.font = [UIFont systemFontOfSize:30];
        
        myView.backgroundColor = [UIColor clearColor];
    
    return myView;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{

    self.currentValue=[self.pickerArray objectAtIndex:row];
    
}


@end
