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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appdelegate.managedObjectContext;

}

- (void)viewWillAppear:(BOOL)animated {
    [self load];
}

- (void)load {

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Reader class])];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"friend == YES"];
    request.predicate = predicate;
    self.friends = [self.moc executeFetchRequest:request error:nil];
    [self.friendsTableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if(searchText.length == 0)
    {
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
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Reader *reader = self.friends[indexPath.row];
    cell.textLabel.text = reader.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.readerPath = indexPath;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"ShowReaderListSegue"]) {
        ReaderListViewController *readerVC = segue.destinationViewController;
        readerVC.moc = self.moc;
    } else if ([segue.identifier isEqualToString:@"FriendDetailSegue"]) {
        FriendDetailViewController *friendVC = segue.destinationViewController;
        friendVC.reader = self.friends[self.readerPath.row];
        friendVC.moc = self.moc;
        NSLog(@"%@", friendVC.reader);
    }

}



@end
