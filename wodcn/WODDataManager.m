//
//  WODDataManager.m
//  wodcn
//
//  Created by 陆思 on 16/5/30.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODDataManager.h"
#import "AppDelegate.h"
@implementation WODDataManager

@synthesize context;

- (WOD*)getWillInsertWOD{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    return [NSEntityDescription insertNewObjectForEntityForName:@"WOD"inManagedObjectContext:context];
}

- (void)insert:(NSDictionary*)data;
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    WOD *record = [NSEntityDescription insertNewObjectForEntityForName:@"WOD"inManagedObjectContext:context];
    record.title=data[@"title"];
    record.desc=data[@"desc"];
    record.type=data[@"type"];
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }
}


//查询
- (NSMutableArray*)query
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"WOD" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (WOD *info in fetchedObjects) {
        [resultArray addObject:info];
    }
    return resultArray;
}



@end