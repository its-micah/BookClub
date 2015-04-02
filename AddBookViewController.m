//
//  AddBookViewController.m
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "AddBookViewController.h"
#import "Book.h"
#import "Reader.h"

@interface AddBookViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property IBOutlet UITextField *titleTextField;
@property IBOutlet UITextField *authorTextField;
@property NSString *image;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
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

    [self.reader addBooksObject:book];

    [self.moc save:nil];
    
    [Book writeImageToDisk:self.imageView.image withFileName:[NSString stringWithFormat:@"%@.png", book.title]];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSelectPictureButtonPressed:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];

}
- (IBAction)onCancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;


    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
