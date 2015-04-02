//
//  FriendDetailViewController.m
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "Reader.h"

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
}

//- (void)viewWillAppear:(BOOL)animated {
//    self.nameLabel.text = self.reader.name;
//
//}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count; //xx.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

    return cell;
}


@end
