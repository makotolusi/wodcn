//
//  Tool.m
//  wodcn
//
//  Created by 陆思 on 16/6/13.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "Tool.h"
#import "WXApi.h"
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


@end
