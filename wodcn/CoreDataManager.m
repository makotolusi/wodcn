//
//  CoreDataManager.m
//  wodcn
//
//  Created by 陆思 on 16/5/18.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"
#import "WOD.h"
@implementation CoreDataManager

@synthesize context;




////查询
//- (NSMutableArray*)query:(int)pageSize andOffset:(int)currentPage
//{
//    
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    self.context = delegate.managedObjectContext;
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    
//    [fetchRequest setFetchLimit:pageSize];
//    [fetchRequest setFetchOffset:currentPage];
//    
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"WOD" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    NSMutableArray *resultArray = [NSMutableArray array];
//    
//    for (WOD *info in fetchedObjects) {
//        NSLog(@"title:%@", info.title);
//        [resultArray addObject:info];
//    }
//    return resultArray;
//}


@end
