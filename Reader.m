//
//  Reader.m
//  BookClub
//
//  Created by Mick Lerche on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "Reader.h"
#import "Book.h"
#import "AppDelegate.h"


@implementation Reader

@dynamic image;
@dynamic name;
@dynamic friend;
@dynamic books;



+ (Reader *)readerWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context {

    Reader * reader = (Reader *)[NSEntityDescription insertNewObjectForEntityForName:@"Reader" inManagedObjectContext:context];
    reader.name = name;
    reader.friend = 0;
    reader.image = @"";

    return reader;
}


+ (void)retrieveReaders:(NSManagedObjectContext *)moc WithCompletion:(void (^)(NSArray *readers))complete {
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSMutableArray *readers = [NSMutableArray new];

                               NSArray *readerNames = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:NSJSONReadingAllowFragments
                                                                                  error:&connectionError];


                               for (NSString *readerName in readerNames) {
                                   Reader *reader = [Reader readerWithName:readerName inManagedObjectContext:moc];
                                   [readers addObject:reader];
                               }
                               complete(readers);
                           }];
}


@end













