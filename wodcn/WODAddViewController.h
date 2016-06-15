//
//  WODAddViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/12.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WODKeyBoardToolBar.h"
#import "WODTypePicker.h"
#import "AFViewShaker.h"
@interface WODAddViewController : UIViewController
- (IBAction)saveEvent:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *wodName;
@property (strong, nonatomic) WODTypePicker *wodType;
@property (weak, nonatomic) IBOutlet UILabel *wodtypeb;
@property (weak, nonatomic) IBOutlet UILabel *dateb;


- (IBAction)dateAction:(id)sender;

- (IBAction)wodtypeaction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *wodTextArea;
@property (nonatomic, strong) AFViewShaker * viewShaker;

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, strong) NSString * type;

- (IBAction)outEdit:(id)sender;
@property (nonatomic, strong) IBOutletCollection(UIView) NSMutableArray * allTextFields;
- (IBAction)wodnameTouchDown:(id)sender;


@end
