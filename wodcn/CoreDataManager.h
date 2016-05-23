//
//  CoreDataManager.h
//  wodcn
//
//  Created by 陆思 on 16/5/18.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

@property (strong,nonatomic)NSManagedObjectContext *context;

- (void)insert:(NSMutableArray*)dataArray;

//查询
- (NSMutableArray*)query:(int)pageSize andOffset:(int)currentPage;

@end
