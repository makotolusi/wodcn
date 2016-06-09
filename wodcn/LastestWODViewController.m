//
//  LastestWODViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/24.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "LastestWODViewController.h"
#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "AuthTool.h"
#import "WXApi.h"
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
                 self.wodDesc.attributedText=attributedString;
              float height=  [self heightForString:self.wodDesc andWidth:self.wodDesc.frame.size.width];
                
                self.wodDesc.frame=CGRectMake(self.wodDesc.frame.origin.x, self.wodDesc.frame.origin.y
                                              , self.wodDesc.frame.size.width, height);
               
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

/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
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



- (IBAction)shareWOD:(id)sender {
   
    [self sendWXImageContent];
   
}

-(void)sendWBMessage{
    if ([AuthTool isAuthorized]) {
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = kRedirectURI;
        authRequest.scope = @"all";
        NSString* token=[[NSUserDefaults   standardUserDefaults] objectForKey:kWBToken];
        
        
        UIImage *wordImage=  [self getImageFromView:self.wodDesc];
        
        WBMessageObject *message = [WBMessageObject message];
        message.text = @"来源于《今日WOD》";
        WBImageObject *image = [WBImageObject object];
        image.imageData = UIImagePNGRepresentation(wordImage);
        message.imageObject = image;
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token: token];
        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
        [WeiboSDK sendRequest:request];
    }else{
        UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
        UIViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"loginView"];
        [self presentViewController:detailViewController animated:YES completion:nil];
    }
}

//UIView -> UIImage
//#import “QuartzCore/QuartzCore.h”
//把UIView 转换成图片
-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void) sendWXImageContent
{
    enum WXScene  *_scene = WXSceneSession;
    UIImage *wordImage=  [self getImageFromView:self.wodDesc];
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"movement.png"]];
    
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImagePNGRepresentation(wordImage);
    
//    //UIImage* image = [UIImage imageWithContentsOfFile:filePath];
//    UIImage* image = [UIImage imageWithData:ext.imageData];
//    ext.imageData = UIImagePNGRepresentation(image);
    
    //    UIImage* image = [UIImage imageNamed:@"res5thumb.png"];
    //    ext.imageData = UIImagePNGRepresentation(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}
@end
