//
//  AddBookViewController.m
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "AddBookViewController.h"
#import "Book.h"

@interface AddBookViewController () <UIImagePickerControllerDelegate>
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
    [self.moc save:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

- (IBAction)onSelectPictureButtonPressed:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];

}
- (IBAction)onCancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;

    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
