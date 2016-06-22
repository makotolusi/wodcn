//
//  Tool.m
//  wodcn
//
//  Created by 陆思 on 16/6/13.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "Tool.h"
#import "WXApi.h"
#import "LGAlertView.h"
@implementation Tool


//UIView -> UIImage
//#import “QuartzCore/QuartzCore.h”
//把UIView 转换成图片
+(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void) sendWXImageContent:(UIView*)view
{
    enum WXScene  *_scene = WXSceneSession;
    UIImage *wordImage=  [self getImageFromView:view];
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


+ (void) sendWXTextContent:(NSString*)text{
    enum WXScene  *_scene = WXSceneSession;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
//    NSString* text=[NSString stringWithFormat:@"%@ \n\n %@",_wodDate.text,_wodDesc.text];
    req.text=text;
    req.scene=_scene;
    [WXApi sendReq:req];
}

+(LGAlertView*)configLGAlertView:(LGAlertView*) alertView{
    alertView.coverColor = [UIColor colorWithWhite:1.f alpha:0.9];
    alertView.layerShadowColor = [UIColor colorWithWhite:0.f alpha:0.3];
    alertView.layerShadowRadius = 4.f;
    alertView.layerCornerRadius = 0.f;
    alertView.layerBorderWidth = 2.f;
    alertView.layerBorderColor = [UIColor colorWithRed:0.f green:0.5 blue:1.f alpha:1.f];
    alertView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.7];
    alertView.buttonsHeight = 44.f;
    alertView.titleFont = [UIFont boldSystemFontOfSize:18.f];
    alertView.titleTextColor = [UIColor blackColor];
    alertView.messageTextColor = [UIColor blackColor];
    alertView.width = MIN(SCREEN_WIDTH, SCREEN_HEIGHT);
    alertView.offsetVertical = 0.f;
    alertView.cancelButtonOffsetY = 0.f;
    alertView.titleTextAlignment = NSTextAlignmentLeft;
    alertView.messageTextAlignment = NSTextAlignmentLeft;
    alertView.destructiveButtonTextAlignment = NSTextAlignmentRight;
    alertView.buttonsTextAlignment = NSTextAlignmentRight;
    alertView.cancelButtonTextAlignment = NSTextAlignmentRight;
    alertView.separatorsColor = [UIColor whiteColor];
    alertView.destructiveButtonTitleColor = [UIColor whiteColor];
    alertView.buttonsTitleColor = [UIColor whiteColor];
    alertView.cancelButtonTitleColor = [UIColor whiteColor];
    alertView.destructiveButtonBackgroundColor = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.5];
    alertView.buttonsBackgroundColor = COLOR_LIGHT_BLUE;//;[UIColor colorWithRed:0.f green:0.5 blue:1.f alpha:0.5];
    alertView.cancelButtonBackgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    alertView.destructiveButtonBackgroundColorHighlighted = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:1.f];
    alertView.buttonsBackgroundColorHighlighted = [UIColor colorWithRed:0.f green:0.5 blue:1.f alpha:1.f];
    alertView.cancelButtonBackgroundColorHighlighted = [UIColor colorWithWhite:0.5 alpha:1.f];
    return alertView;
}

@end
