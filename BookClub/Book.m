//
//  Book.m
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "Book.h"


@implementation Book

@dynamic title;
@dynamic author;
@dynamic image;
@dynamic readers;
@dynamic comments;

+ (NSString *)fullPathName:(NSString *)fileName {
    NSString *adjustedFileName = fileName;
    if ([fileName containsString:@"http"]) {
        adjustedFileName = [fileName lastPathComponent];
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];

    NSLog(@"%@", [NSString stringWithFormat:@"%@/%@", docDir, adjustedFileName]);
    return [NSString stringWithFormat:@"%@/%@", docDir, adjustedFileName];
}


#pragma mark - Image methods

+ (void)writeImageToDisk:(UIImage *)image withFileName:(NSString *)fileName {
    NSLog(@"%f,%f",image.size.width,image.size.height);

    NSLog(@"saving png");
    NSString *pngFilePath = [Book fullPathName:fileName];
    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
    [data1 writeToFile:pngFilePath atomically:YES];

    //    NSLog(@"saving jpeg");
    //    NSString *jpegFilePath = [NSString stringWithFormat:@"%@/test.jpeg",docDir];
    //    NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];//1.0f = 100% quality
    //    [data2 writeToFile:jpegFilePath atomically:YES];

    NSLog(@"saving image done");

}

+ (UIImage *)readImageFromDisk:(NSString *)fileName {

    UIImage *testImage = [UIImage imageWithContentsOfFile:[Book fullPathName:fileName]];
    
    return testImage;
}

@end
