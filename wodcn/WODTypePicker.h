//
//  WODTypePicker.h
//  wodcn
//
//  Created by 陆思 on 16/5/17.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WODTypePicker : UIView<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>

@property (strong,nonatomic) NSArray *pickerArray;

@property (strong,nonatomic) UIPickerView *picker;

@property (strong,nonatomic) NSString *currentValue;

- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray*)data;

@end
