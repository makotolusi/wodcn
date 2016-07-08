//
//  ProfileUpdateController.m
//  wodcn
//
//  Created by 陆思 on 16/7/7.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "ProfileUpdateController.h"
#import "LGAlertView.h"
#import "Profile.h"
#import "ProfileDataManager.h"
#import "InputHelper.h"
@interface ProfileUpdateController ()<UITextFieldDelegate>

@end

@implementation ProfileUpdateController

-(void)viewWillAppear:(BOOL)animated{
// [inputHelper setupInputHelperForView:self.view withDismissType:InputHelperDismissTypeTapGusture];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _sex.userInteractionEnabled=YES;
//    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sexShow:)];
//    [self.sex addGestureRecognizer:labelTapGestureRecognizer];
    // Do any additional setup after loading the view.
    _sex.delegate=self;
    
    [inputHelper setupInputHelperForView:self.scrollView withDismissType:InputHelperDismissTypeTapGusture];
    
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:@"性别"
                                                        message:nil
                                                          style:LGAlertViewStyleActionSheet
                                                   buttonTitles:@[@"男",@"女"]
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                                  actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                      NSLog(@"actionHandler, %@, %lu", title, (long unsigned)index);
                                                      _sex.text=title;
                                                  }
                                                  cancelHandler:nil
                                             destructiveHandler:nil];
    //    [Tool configLGAlertView:alertView];
    
    [alertView showAnimated:YES completionHandler:nil];
    return NO;
}

- (IBAction)submit:(id)sender {
    ProfileDataManager *manager=[[ProfileDataManager alloc] init];
    id obj= manager.getWillInsert;
    if ([obj isKindOfClass:[Profile class]]) {
        Profile *profile=(Profile*)obj;
        profile.name=_name.text;
        profile.sex=_sex.text;
        profile.box=_box.text;
        profile.height=[NSNumber numberWithBool:_height.text.integerValue] ;
        profile.weight=[NSNumber numberWithInteger:_weight.text.integerValue];
    }
    [manager save];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
