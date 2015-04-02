//
//  BookCommentsViewController.h
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "ViewController.h"
#import "Book.h"

@interface BookCommentsViewController : ViewController

@property NSManagedObjectContext *moc;
@property Book *book;

@end
