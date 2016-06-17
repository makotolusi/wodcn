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
#import "NSString+Extension.h"
#import "Tool.h"
#import "WODDataManager.h"
#import "WOD.h"
#import "NSDate+Extension.h"
#import "LBProgressHUD.h"
#import "InitData.h"
@interface LastestWODViewController ()

@end

@implementation LastestWODViewController
{
    NSMutableArray *lastestWODScoreData;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(void)notice:(id)sender{
    NSLog(@"%@",sender);
    WODDataManager *dataManager=[[WODDataManager alloc] init];
    NSMutableArray* alexwods= [dataManager queryAlex];
     [self loadWODData:alexwods[0]];
}

-(void)loadWODData:(WOD*)wod{
    self.wodDate.text=wod.title;//[wod.date stringFromDate:@"MM dd, yyyy"];
    self.wodSource.text=[@"By " stringByAppendingString:ALEX];
    NSMutableAttributedString *attri= [wod.desc alexWODHtmlFormat];
    if (attri!=nil) {
        self.wodDesc.attributedText=attri;
        float height=  [self heightForString:self.wodDesc andWidth:self.wodDesc.frame.size.width];
        
        self.wodDesc.frame=CGRectMake(self.wodDesc.frame.origin.x, self.wodDesc.frame.origin.y
                                      , self.wodDesc.frame.size.width-20, height);
        [_scrollView setContentSize:CGSizeMake(0, _wodDate.frame.size.height+_wodSource.frame.size.height+_wodDesc.frame.size.height)];
        [self.view bringSubviewToFront:_finishLabel];
                    [self.view bringSubviewToFront:_scoreLabel];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"reloadLastedWOD" object:nil];
    
    WODDataManager *dataManager=[[WODDataManager alloc] init];
    NSMutableArray* alexwods= [dataManager queryAlex];
    if (alexwods.count==0) {//毫无数据
        [InitData initData:self.view];
    }else{
        WOD *lasted= alexwods[0];
        [self loadWODData:alexwods[0]];
        if ([lasted.date isTomorrow]) {
            [InitData initData:self.view];//数据较久
        }else{
            [self loadWODData:alexwods[0]];
        }
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 20)];
    
    statusBarView.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:statusBarView];

   
   
    
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
    if ([_wodDesc.text isEqualToString:@"正在读取......" ]) {
        
    }else
        [Tool sendWXImageContent:self.view];
   
}

//-(void)sendWBMessage{
//    if ([AuthTool isAuthorized]) {
//        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
//        authRequest.redirectURI = kRedirectURI;
//        authRequest.scope = @"all";
//        NSString* token=[[NSUserDefaults   standardUserDefaults] objectForKey:kWBToken];
//        
//        
//        UIImage *wordImage=  [self getImageFromView:self.wodDesc];
//        
//        WBMessageObject *message = [WBMessageObject message];
//        message.text = @"来源于《今日WOD》";
//        WBImageObject *image = [WBImageObject object];
//        image.imageData = UIImagePNGRepresentation(wordImage);
//        message.imageObject = image;
//        
//        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token: token];
//        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                             @"Other_Info_1": [NSNumber numberWithInt:123],
//                             @"Other_Info_2": @[@"obj1", @"obj2"],
//                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//        //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
//        [WeiboSDK sendRequest:request];
//    }else{
//        UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
//        UIViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"loginView"];
//        [self presentViewController:detailViewController animated:YES completion:nil];
//    }
//}



- (void) sendWXTextContent{
     enum WXScene  *_scene = WXSceneSession;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    NSString* text=[NSString stringWithFormat:@"%@ \n\n %@",_wodDate.text,_wodDesc.text];
    req.text=text;
    req.scene=_scene;
    [WXApi sendReq:req];
}
- (IBAction)shareAction:(id)sender {
    if ([_wodDesc.text isEqualToString:@"疯狂手抄中......" ]) {
        
    }else
        [Tool sendWXImageContent:self.view];
}
@end
