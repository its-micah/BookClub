//
//  Book.h
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSSet *readers;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addReadersObject:(NSManagedObject *)value;
- (void)removeReadersObject:(NSManagedObject *)value;
- (void)addReaders:(NSSet *)values;
- (void)removeReaders:(NSSet *)values;

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;
+ (UIImage *)readImageFromDisk:(NSString *)imageName;
+ (void)writeImageToDisk:(UIImage *)image withFileName:(NSString *)fileName;


@end
