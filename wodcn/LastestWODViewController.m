//
//  LastestWODViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/24.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "LastestWODViewController.h"

@interface LastestWODViewController ()

@end

@implementation LastestWODViewController
{
    NSMutableArray *lastestWODScoreData;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 20)];
    
    statusBarView.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:statusBarView];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/rss+xml",nil];//application/rss+xml
    [manager GET:@"http://www.alexandriacrossfit.com/feed/" parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
    
        NSXMLParser *parser = (NSXMLParser *)responseObject;
                NSDictionary *dic = [NSDictionary dictionaryWithXMLParser:parser];
                NSDictionary *channel=dic[@"channel"];
                NSString* wodSource=channel[@"title"];
                NSArray* item=channel[@"item"];
                NSDictionary* totdayWod=item[0];
//               NSString* wodDescription=totdayWod[@"description"];
                NSString* wodDate=totdayWod[@"title"];
            NSString* link=totdayWod[@"link"];
                self.wodDate.text=wodDate;
                self.wodSource.text=[@"By " stringByAppendingString:wodSource];
        
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",nil];//application/rss+xml
        [manager GET:link parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
            
            NSString* searchText=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSError *error = NULL;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?i)<div class=\"content\"[\\s\\S]+?</div>" options:NSRegularExpressionCaseInsensitive error:&error];
            NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
            if (result) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[[searchText substringWithRange:result.range] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                [attributedString  addAttribute:NSFontAttributeName
                                                value:[UIFont fontWithName:@"Arial-BoldItalicMT"  size:15]
                                               range:NSMakeRange(0, attributedString.length)];
//                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attributedString.length)];
                self.wodDesc.attributedText=attributedString;
//                NSLog(@"%@\n", [searchText substringWithRange:result.range]);
            }
            //
            
        } failure:^(AFHTTPRequestOperation *operation,NSError *error){
            
            NSLog(@"error = %@",error);
            
        }];

        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
        NSLog(@"error = %@",error);
        
    }];

                           
    self.lastestWODScoreList.delegate=self;
    self.lastestWODScoreList.dataSource=self;
    lastestWODScoreData=[[NSMutableArray alloc] init];
    NSString *path= [[NSBundle mainBundle] pathForResource:@"LastestWODScore" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    lastestWODScoreData = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"成绩";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [lastestWODScoreData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"lastestWodScoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    NSDictionary* score=[lastestWODScoreData objectAtIndex:indexPath.row];
    cell.textLabel.text = score[@"name"];
    cell.detailTextLabel.text=score[@"score"];
    return cell;
}


- (IBAction)timerMenuShow:(id)sender {
    if (self.timerView.isHidden) {
        [self setHidden:NO];
    }else
        [self setHidden:YES];
    
    
}

-(void)setHidden:(BOOL)hidden
{
    if (hidden) {
        //隐藏时
        self.timerView.alpha= 1.0f;
        [UIView beginAnimations:@"fadeOut" context:nil];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationDelegate:self];//设置委托
        [UIView setAnimationDidStopSelector:@selector(animationStop)];//当动画结束时，我们还需要再将其隐藏
        self.timerView.alpha = 0.0f;
        [UIView commitAnimations];
    }
    else
    {
        self.timerView.alpha= 0.0f;
        [self.timerView setHidden:hidden];
        [UIView beginAnimations:@"fadeIn" context:nil];
        [UIView setAnimationDuration:0.7];
        self.timerView.alpha= 1.0f;
        [UIView commitAnimations];
    }
}
-(void)animationStop
{
    [self.timerView setHidden:!self.timerView.hidden];
}



@end
