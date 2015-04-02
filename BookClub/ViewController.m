//
//  ViewController.m
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Reader.h"
#import "ReaderListViewController.h"
#import "FriendDetailViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;
@property NSArray *friends;
@property BOOL isFiltered;
@property NSMutableArray *searchResults;
@property NSIndexPath *readerPath;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appdelegate.managedObjectContext;
    self.searchBar.delegate = self;
    self.isFiltered = NO;
    self.searchResults = [NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated {
    [self load];
    NSArray *orderedArray = [NSArray new];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *sortedArray = [self.friends sortedArrayUsingDescriptors:@[sortDescriptor]];
    orderedArray = [NSArray arrayWithArray:sortedArray];
    [self.friendsTableView reloadData];
}

- (void)load {

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Reader class])];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"friend == YES"];
    request.predicate = predicate;
    self.friends = [self.moc executeFetchRequest:request error:nil];
    [self.friendsTableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if(searchText.length == 0) {
        self.isFiltered = FALSE;
    } else {
        self.isFiltered = true;
        self.searchResults = [[NSMutableArray alloc] init];
        for (Reader *reader in self.friends) {
            NSRange stopNameRange = [reader.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (stopNameRange.location != NSNotFound) {
                [self.searchResults addObject:reader];
            }
        }
    }

    [self.friendsTableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.isFiltered) {
        return self.searchResults.count;
    } else {
        return self.friends.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (self.isFiltered) {
        Reader *reader = self.searchResults[indexPath.row];
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.layer.cornerRadius = 36.0;
        cell.textLabel.text = reader.name;
        cell.imageView.image = [UIImage imageNamed:reader.name];
        return cell;
    } else {
        Reader *reader = self.friends[indexPath.row];
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.layer.cornerRadius = 36.0;
        cell.textLabel.text = reader.name;
        cell.imageView.image = [UIImage imageNamed:reader.name];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.isFiltered) {
        Reader *reader = self.searchResults[indexPath.row];
        [self callFriendDetailViewControllerForReader:reader];
    } else {
        Reader *reader = self.friends[indexPath.row];
        [self callFriendDetailViewControllerForReader:reader];
    }
}

- (void)callFriendDetailViewControllerForReader:(Reader *)reader {

    FriendDetailViewController *friendVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FriendDetailViewController"];
    friendVC.reader = reader;
    friendVC.moc = self.moc;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:friendVC];
    navVC.title = reader.name;
    navVC.navigationItem.rightBarButtonItem = UIBarButtonItemStylePlain;
    [self showViewController:friendVC sender:nil];

}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowReaderListSegue"]) {
        ReaderListViewController *readerVC = segue.destinationViewController;
        readerVC.moc = self.moc;
    }

}



@end
