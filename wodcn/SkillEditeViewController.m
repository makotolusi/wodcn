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
@interface SkillEditeViewController ()

@end

@implementation SkillEditeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text=self.skillName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    SkillRecord *data = [NSEntityDescription insertNewObjectForEntityForName:@"SkillRecord" inManagedObjectContext:delegate.managedObjectContext];
    data.name=self.name.text;
    NSDate *date=[NSDate date];
    data.date=date;
    data.desc=self.desc.text;
    data.type=@"ForTime";
    data.score=[NSDecimalNumber decimalNumberWithString:self.score.text];
    NSError *error;
    if(![delegate.managedObjectContext save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }

    [self.navigationController popViewControllerAnimated:YES];
}
@end
