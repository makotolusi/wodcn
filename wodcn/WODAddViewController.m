//
//  WODAddViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/12.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODAddViewController.h"
#import "WODKeyBoardToolBar.h"
#import "WODTagsView.h"
#import "CoreDataManager.h"
#import "WODDataManager.h"
#import "SkillDataManager.h"
#import "AFViewShaker.h"
#import "LGAlertView.h"
#import "NSDate+Extension.h"
#import "NSString+Extension.h"
#import "Tool.h"
@interface WODAddViewController ()<WODKeyBoardToolBarDelegate,UITextViewDelegate,WODTagsViewDelegate>

{
    
    WODKeyBoardToolBar* wodKeyboardtoolbar;
    WODKeyBoardToolBar* wodpickerdone;
    NSString* placeholderString;
    WODTagsView *view;
    NSString* prefix;
    BOOL *isUpdate;
    
}
@end

@implementation WODAddViewController

- (void)viewDidLoad {
    _wodTextArea.layer.borderWidth=0.7;
    _wodTextArea.layer.borderColor=[UIColorFromRGB(0xCACACA) CGColor];
    _wodTextArea.layer.cornerRadius=6;
    
    _wodtypeb.layer.borderWidth=0.7;
    _wodtypeb.layer.borderColor=[UIColorFromRGB(0xCACACA) CGColor];
    _wodtypeb.layer.cornerRadius=6;
    
    _dateb.layer.borderWidth=0.7;
    _dateb.layer.borderColor=[UIColorFromRGB(0xCACACA) CGColor];
    _dateb.layer.cornerRadius=6;
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:self.allTextFields];
    [super viewDidLoad];
      prefix=@"";
    placeholderString=@"<请输入WOD信息> \n例如 \n25 Push-up \n25 sit-up \n400m Run";
    wodKeyboardtoolbar=[[WODKeyBoardToolBar alloc] init];
    wodKeyboardtoolbar.wodToolbarDelegate=self;
    
    wodpickerdone=[[WODKeyBoardToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,  SCREEN_HEIGHT*0.3)];
    wodpickerdone.wodToolbarDelegate=self;
    
    self.wodType= [[WODTypePicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.3) Data:[NSArray arrayWithObjects:@"计时",@"计次", nil]];
    [self.view addSubview:self.wodType];
    
//    self.wodTypeLabel.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateAction:)];
    
    [self.dateb addGestureRecognizer:labelTapGestureRecognizer];
    
    UITapGestureRecognizer *typeTouch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wodtypeaction:)];
    
    [self.wodtypeb addGestureRecognizer:typeTouch];
    
    //定义一个toolBar
    wodKeyboardtoolbar.frame=CGRectMake(0, 0, SCREEN_WIDTH, 30);
    [self.wodTextArea setInputAccessoryView:wodKeyboardtoolbar];
    self.wodTextArea.delegate=self;
    self.wodTextArea.text =placeholderString;
    self.wodTextArea.textColor=[UIColor lightGrayColor];
    [self.wodName setInputAccessoryView:wodKeyboardtoolbar];
    if (StringIsNullOrEmpty(self.name)) {
        isUpdate=NO;
    }else{
        isUpdate=YES;
        _wodName.text=_name;
        _wodtypeb.text=_method;
        _wodtypeb.textColor=[UIColor blackColor];
        _dateb.text=_date;
        _dateb.textColor=[UIColor blackColor];
        _wodTextArea.text=_desc;
         self.wodTextArea.textColor=[UIColor blackColor];
    }
}

-(void)off{

    if ([self.wodTextArea isFirstResponder]) {
        [self.wodTextArea resignFirstResponder];
    }if ([self.wodName isFirstResponder]) {
        [self.wodName resignFirstResponder];
    }else
        [self inView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)popView:(UITapGestureRecognizer *)recognizer{
     [self.wodTextArea resignFirstResponder];
    [self.wodName resignFirstResponder];
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"#"]) {
        view=[[WODTagsView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-[[UIApplication sharedApplication] statusBarFrame].size.height+5, SCREEN_WIDTH, 300)];
        view.wodTagDelegate=self;
        [self.view addSubview:view];
        return NO;
    }else{
        if (view) {
            if([text isEqualToString:@"\n"]||[text isEqualToString:@" "]){
                return NO;
            }
            if([text isEqualToString:@""]&&StringNotNullAndEmpty(prefix)){
                prefix=[prefix substringToIndex:prefix.length-1];
            }
            SkillDataManager *skill=[[SkillDataManager alloc] init];
             prefix=[prefix stringByAppendingString:text];
            view.tags=[skill queryLikeName:prefix];
            [view.tagsTable reloadData];
            return NO;
        }
    }
    
    return YES;
}

-(void)didSelectTag:(NSString*)text{
    NSMutableString *str=[[NSMutableString alloc] initWithString:self.wodTextArea.text];
    [str insertString:text atIndex:self.wodTextArea.selectedRange.location];
    self.wodTextArea.text=str;
    view=nil;
    prefix=@"";
}

-(void)textViewDidBeginEditing:(UITextView*)textView{
    if([self.wodTextArea.text isEqualToString:placeholderString]){
        self.wodTextArea.text=@"";
        self.wodTextArea.textColor=[UIColor blackColor];
    }
}

-(void)textViewDidEndEditing:(UITextView*)textView{
    if(self.wodTextArea.text.length<1){
        self.wodTextArea.text=placeholderString;
        self.wodTextArea.textColor=[UIColor lightGrayColor];
    }
}

- (IBAction)saveEvent:(id)sender{
    if(StringIsNullOrEmpty(self.wodName.text)){
        [[[AFViewShaker alloc] initWithView:self.wodName] shake];
        return;
    }
    if([self.wodtypeb.text isEqualToString:@"类型"]){
        [[[AFViewShaker alloc] initWithView:self.wodtypeb] shake];
        return;
    }
    if([self.dateb.text isEqualToString:@"日期"]){
        [[[AFViewShaker alloc] initWithView:self.dateb] shake];
        return;
    }
    if([self.wodTextArea.text isEqualToString:placeholderString]){
         [[[AFViewShaker alloc] initWithView:self.wodTextArea] shake];
        return;
    }
    WODDataManager *manager=[[WODDataManager alloc] init];
    if (isUpdate) {
        WOD* wod=[manager queryOneByName:_name];
        wod.title=_wodName.text;
        wod.desc=_wodTextArea.text;
        wod.date= [_dateb.text dateFromString:@"yyyy/MM/dd"];
        wod.method=_wodtypeb.text;
        wod.type=MYWOD;
        [manager update:wod];
        [self.navigationController popToRootViewControllerAnimated :YES];
    }else{
        NSDictionary *wod=@{@"title":self.wodName.text,@"type":MYWOD,@"desc":self.wodTextArea.text,@"date":[_dateb.text dateFromString:@"yyyy/MM/dd"],@"method":_wodtypeb.text};
        [manager insert:wod];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}
- (IBAction)outEdit:(id)sender {

    NSString *title = NSLocalizedString(@"退出编辑？", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
        
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
     [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)wodnameTouchDown:(id)sender {
       [self inView];
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

                                         _dateb.text=[datePicker.date stringFromDate];
                                         _dateb.textColor=[UIColor blackColor];
                                     }
                                 }
                                 cancelHandler:^(LGAlertView *alertView) {
                                     NSLog(@"cancelHandler");
                                 }
                            destructiveHandler:^(LGAlertView *alertView) {
                                NSLog(@"destructiveHandler");
                            }] showAnimated:YES completionHandler:nil];
}

- (void)wodtypeaction:(UITapGestureRecognizer *)recognizer {
    LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:@"WOD类型"
                                                        message:nil
                                                          style:LGAlertViewStyleActionSheet
                                                   buttonTitles:@[@"计时",@"计次"]
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                                  actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                      NSLog(@"actionHandler, %@, %lu", title, (long unsigned)index);
                                                      _wodtypeb.text=title;
                                                      _wodtypeb.textColor=[UIColor blackColor];
                                                  }
                                                  cancelHandler:nil
                                             destructiveHandler:nil];
    [Tool configLGAlertView:alertView];
    
    [alertView showAnimated:YES completionHandler:nil];

}
@end
