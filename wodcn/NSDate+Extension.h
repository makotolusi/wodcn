//
//  NSDate+Extension.h
//  wodcn
//
//  Created by 陆思 on 16/5/27.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+(NSDate*) convertDateFromString:(NSString*)uiDate;
-(NSString *)stringFromDate;
-(NSString *)stringFromDate:(NSString*)format;
-(BOOL)isTomorrow;
@end
