//
//  SMFAppDelegate.h
//  StackMobForm
//
//  Created by Wess Cope on 1/25/13.
//  Copyright (c) 2013 WessCope. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMClient;
@interface SMFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow                  *window;
@property (strong, nonatomic) UINavigationController    *navController;

@property (readonly, strong, nonatomic) NSManagedObjectContext       *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel         *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) SMClient *client;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
