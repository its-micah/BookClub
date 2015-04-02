//
//  BookCommentsViewController.m
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "BookCommentsViewController.h"
#import "Book.h"
#import "Comment.h"

@interface BookCommentsViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@end

@implementation BookCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (IBAction)createCommentAlert:(id)sender {
    UIAlertController *commentController = [UIAlertController alertControllerWithTitle:@"Add comment" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [commentController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        nil;
    }];

    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Okay"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action) {

                                   UITextField *textField = commentController.textFields.firstObject;
                                   Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Comment class]) inManagedObjectContext:self.moc];
                                   comment.comment = textField.text;
                                   [self.moc save:nil];
                               }];

    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action) {
                                       nil;
                                   }];

    [commentController addAction:cancelAction];
    [commentController addAction:okAction];

    [self presentViewController:commentController animated:YES completion:^{
        nil;
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0; //xx.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

    return cell;
}


@end
