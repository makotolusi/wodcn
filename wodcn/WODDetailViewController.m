//
//  WODDetailViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/4.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODDetailViewController.h"
#import "WODAddViewController.h"
#import "NSString+Extension.h"
#import "AFNetworking.h"
#import "NSDate+Extension.h"
@interface WODDetailViewController ()

@end

@implementation WODDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wodName.text=_wodDic[@"name"];
    NSDate* date= _wodDic[@"date"];
    if ([ _woddate.text isEqualToString:@"Label"]) {
        [_woddate setHidden:YES];
    }
    if (StringIsNullOrEmpty(_wodDic[@"type"])) {
        self.wodType.text=@"For Time";
    }else
    if([_wodDic[@"type"] isEqualToString:@"alex"]){
        //alex
        self.wodType.text=[@"By " stringByAppendingString:ALEX  ];
        self.wodDesc.attributedText=[_wodDic[@"desc"] alexWODHtmlFormat];
        _woddate.text=[date stringFromDate:ALEX_DATE_FORMAT];
    }else{
        self.wodType.text=_wodDic[@"type"];
        self.wodDesc.text=_wodDic[@"desc"];
    }
   

       
    
   
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    
}

- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)edit{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    WODAddViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"WODAdd"];
    detailViewController.name= self.wodName.text;
    detailViewController.desc=self.wodDesc.text;
    detailViewController.type=self.wodType.text;
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
