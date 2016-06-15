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
@interface WODDetailViewController ()

@end

@implementation WODDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wodName.text=_wodDic[@"name"];
    _woddate.text=_wodDic[@"date"];
    if ([ _woddate.text isEqualToString:@"Label"]) {
        [_woddate setHidden:YES];
    }
    if (StringIsNullOrEmpty(_wodDic[@"type"])) {
        self.wodType.text=@"For Time";
    }else
    if([_wodDic[@"type"] isEqualToString:@"alex"]){
        //alex
        self.wodType.text=[@"By " stringByAppendingString:_wodDic[@"wodSource"]  ];
        self.wodDesc.text=_wodDic[@"desc"];
         AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",nil];//
        [manager GET:_wodDic[@"link"] parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
            
            NSString* searchText=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSMutableAttributedString *attri= [searchText alexWodDescriptionFormat];
            if (attri!=nil) {
                self.wodDesc.attributedText=attri;
                float height=  [self heightForString:self.wodDesc andWidth:self.wodDesc.frame.size.width];
                
                self.wodDesc.frame=CGRectMake(self.wodDesc.frame.origin.x, self.wodDesc.frame.origin.y
                                              , self.wodDesc.frame.size.width, height);
            }
            
            [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, _woddate.frame.size.height+_wodType.frame.size.height+_wodDesc.frame.size.height)];
            
        } failure:^(AFHTTPRequestOperation *operation,NSError *error){
            
            NSLog(@"error = %@",error);
            
        }];
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
