//
//  FriendDetailViewController.m
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "AddBookViewController.h"
#import "BookCommentsViewController.h"
#import "AppDelegate.h"
#import "Reader.h"
#import "Book.h"


@interface FriendDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSArray *books;
@property (weak, nonatomic) IBOutlet UITableView *booksTableView;
@property (weak, nonatomic) IBOutlet UIImageView *readerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBooksLabel;


@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.readerImageView.layer.masksToBounds = YES;
    self.readerImageView.layer.cornerRadius = 75;
    self.nameLabel.text = self.reader.name;
    self.readerImageView.image = [UIImage imageNamed:self.reader.name];

    [self load];
}

- (void)viewWillAppear:(BOOL)animated {
    [self load];
}

- (void)load {

    self.books = [self.reader.books allObjects];


//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Book class])];
//    self.books = [self.moc executeFetchRequest:request error:nil];
    self.numberOfBooksLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.books.count];
    [self.booksTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Book *book = self.books[indexPath.row];
    cell.textLabel.text = book.title;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddBookViewController *addVC = segue.destinationViewController;
    addVC.moc = self.moc;
    addVC.reader = self.reader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Book *book = self.books[indexPath.row];
    [self callCommentsViewControllerForBook:book];

}

- (void)callCommentsViewControllerForBook:(Book *)book {
    BookCommentsViewController *bookVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BookCommentsViewController"];
    bookVC.book = book;
    bookVC.moc = self.moc;
}



@end
