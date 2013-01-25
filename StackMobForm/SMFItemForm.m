//
//  SMFItemForm.m
//  StackMobForm
//
//  Created by Wess Cope on 1/25/13.
//  Copyright (c) 2013 WessCope. All rights reserved.
//

#import "SMFItemForm.h"
#import "Item.h"
#import "SMFAppDelegate.h"

@implementation SMFItemForm

+ (Class)managedObjectClass
{
    return [Item class];
}

+ (NSManagedObjectContext *)managedObjectContext
{
    return ((SMFAppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
}

+ (NSArray *)fields
{
    return @[@"title", @"details", @"note"];
}

@end
