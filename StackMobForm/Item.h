//
//  Item.h
//  StackMobForm
//
//  Created by Wess Cope on 1/25/13.
//  Copyright (c) 2013 WessCope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * note;

@end
