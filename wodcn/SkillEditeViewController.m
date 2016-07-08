//
//  SkillEditeViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/27.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "SkillEditeViewController.h"
#import "SkillRecord.h"
#import "AppDelegate.h"
#import "SkillRecordDataManager.h"
#import "LGAlertView.h"
#import "NSDate+Extension.h"
#import "NSString+Extension.h"
@interface SkillEditeViewController ()
{
    NSDate* date;
}
@end

@implementation SkillEditeViewController

- (void)viewDidLoad {
    date=[NSDate date];
    _dateL.text=[date stringFromDate];
    [super viewDidLoad];
    self.name.text=self.skillName;
    if ([_skillType isEqualToString:@"weight"]) {
        [_wsv setHidden:NO];
        [_rsv setHidden:YES];
    }else{
        [_wsv setHidden:YES];
        [_rsv setHidden:NO];
    }
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateAction:)];
    
    [self.dateL addGestureRecognizer:labelTapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    SkillRecord *data = [NSEntityDescription insertNewObjectForEntityForName:@"SkillRecord" inManagedObjectContext:delegate.managedObjectContext];
    data.name=self.name.text;
//    NSDate *date=[NSDate date];
    data.date=date;
    data.desc=self.desc.text;
    data.type=_skillType;
    NSDecimalNumber* score;
    if ([_skillType isEqualToString:@"weight"]) {
        score=[NSDecimalNumber decimalNumberWithString:self.score.text];
    }else
        score=[NSDecimalNumber decimalNumberWithString:self.repsL.text];
    data.score=score;
    NSError *error;
    if(![delegate.managedObjectContext save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dateAction:(UITapGestureRecognizer *)recognizer{
    UIDatePicker *datePicker = [UIDatePicker new];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, 110.f);
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
    datePicker.locale = locale;
    [[[LGAlertView alloc] initWithViewAndTitle:@"日期"
                                       message:nil
                                         style:LGAlertViewStyleActionSheet
                                          view:datePicker
                                  buttonTitles:@[@"完成"]
                             cancelButtonTitle:@"取消"
                        destructiveButtonTitle:nil
                                 actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                     NSLog(@"actionHandler, %@, %lu", title, (long unsigned)index);
                                     if (index==0) {
                                         
                                         _dateL.text=[datePicker.date stringFromDate];
                                         _dateL.textColor=[UIColor blackColor];
                                         date=datePicker.date;
                                     }
                                 }
                                 cancelHandler:^(LGAlertView *alertView) {
                                     NSLog(@"cancelHandler");
                                 }
                            destructiveHandler:^(LGAlertView *alertView) {
                                NSLog(@"destructiveHandler");
                            }] showAnimated:YES completionHandler:nil];
}


@end
