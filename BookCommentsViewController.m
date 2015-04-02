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

@property NSArray *commentsArray;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;

@end

@implementation BookCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.commentsArray = [NSMutableArray new];
    self.bookTitleLabel.text = self.book.title;
    self.bookAuthorLabel.text = self.book.author;
    NSURL *imageURL = [NSURL URLWithString:self.book.image];

    UIImage *imageFromFile = [Book readImageFromDisk:[NSString stringWithFormat:@"%@.png", self.book.title]];
    self.bookImageView.image = imageFromFile;

    [self loadComments];
}

- (void)loadComments {

    self.commentsArray = [self.book.comments allObjects];
    [self.commentsTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadComments];
    [self.commentsTableView reloadData];
    
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
                                   [self.book addCommentsObject:comment];
                                   [self.moc save:nil];
                                   [self loadComments];
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
    return self.commentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Comment *comment = self.commentsArray[indexPath.row];
    cell.textLabel.text = comment.comment;
    return cell;
}


@end
