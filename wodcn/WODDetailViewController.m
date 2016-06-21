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
#import "Tool.h"
@interface WODDetailViewController ()

@end

@implementation WODDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.wodType setHidden:YES];
    self.wodName.text=_wodDic[@"title"];
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
//        self.wodType.text=_wodDic[@"type"];
        self.wodDesc.attributedText=[_wodDic[@"desc"] alexWODHtmlFormat];
    }
   
    float height=  [self heightForString:self.wodDesc andWidth:self.wodDesc.frame.size.width];
    
    self.wodDesc.frame=CGRectMake(self.wodDesc.frame.origin.x, self.wodDesc.frame.origin.y
                                  , self.wodDesc.frame.size.width-20, height);

        [_scrollView setContentSize:CGSizeMake(0, _woddate.frame.size.height+_wodType.frame.size.height+_wodDesc.frame.size.height)];
    
    
    if([_wodDic[@"type"] isEqualToString:@"alex"]){
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
        [rightButton setTitleTextAttributes :[ NSDictionary dictionaryWithObjectsAndKeys :  [ UIFont fontWithName : @"Helvetica-Bold" size : 17.0 ], NSFontAttributeName ,  [ UIColor whiteColor ], NSForegroundColorAttributeName ,    nil ]

                                  forState : UIControlStateNormal ];
        self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
        self.navigationItem.rightBarButtonItem=rightButton;
    }else{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    }
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
  
    
    if([_wodDic[@"type"] isEqualToString:@"alex"]){
        [Tool sendWXImageContent:self.scrollView];
    }else{
        UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
        WODAddViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"WODAdd"];
        detailViewController.name= self.wodName.text;
        detailViewController.desc=self.wodDesc.text;
        detailViewController.type=self.wodType.text;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}


@end
