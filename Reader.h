//
//  Reader.h
//  BookClub
//
//  Created by Mick Lerche on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Reader : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * name;
@property BOOL friend;
@property (nonatomic, retain) NSSet *books;
@end

@interface Reader (CoreDataGeneratedAccessors)

- (void)addBooksObject:(Book *)value;
- (void)removeBooksObject:(Book *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;

+ (void)retrieveReaders:(NSManagedObjectContext *)moc WithCompletion:(void (^)(NSArray *readers))complete;
+ (void)retrieveReadersWithCompletion:(void (^)(NSArray *readers))complete;


@end
