//
//  AddBookViewController.m
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "AddBookViewController.h"
#import "Book.h"

@interface AddBookViewController ()
@property IBOutlet UITextField *titleTextField;
@property IBOutlet UITextField *authorTextField;
@property NSString *image;
@end

@implementation AddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)onSaveButtonPressed:(id)sender {
    Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book"
                                               inManagedObjectContext:self.moc];

    book.title = self.titleTextField.text;
    book.author = self.authorTextField.text;
    book.image = self.image;
    [self.moc save:nil];
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}
- (IBAction)onSetImageButtonPressed:(id)sender {

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
