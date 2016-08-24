//
//  ProfileDataManager.m
//  wodcn
//
//  Created by 陆思 on 16/7/7.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "ProfileDataManager.h"
#import "AppDelegate.h"
#import "Profile.h"
@implementation ProfileDataManager
@synthesize context;

//插入数据
- (id)getWillInsert{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    return [NSEntityDescription insertNewObjectForEntityForName:@"Profile"inManagedObjectContext:context];
}

- (void)save
{
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }
}

//查询
- (NSArray*)query
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Profile" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

//查询
- (Profile*)queryOne
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    fetchRequest.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"title = '%@' ", name]];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Profile" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects.count!=0) {
        return fetchedObjects[0];
    }
    return nil;
}

@end
