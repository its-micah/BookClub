//
//  ReadsListViewController.m
//  BookClub
//
//  Created by Micah Lanier on 4/1/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "ReaderListViewController.h"
#import "Reader.h"

@interface ReaderListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *readersTableView;
@property NSArray *readersArray;

@end

@implementation ReaderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Reader class])];
    self.readersArray = [self.moc executeFetchRequest:request error:nil];

    if (self.readersArray.count == 0) {
        [Reader retrieveReaders:self.moc WithCompletion:^(NSArray *readers) {
            self.readersArray = readers;
            [self.readersTableView reloadData];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Reader *reader = self.readersArray[indexPath.row];
    reader.friend = !reader.friend;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (reader.friend) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    [self.moc save:nil];
    [self.readersTableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.readersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Reader *reader = self.readersArray[indexPath.row];
    cell.textLabel.text = reader.name;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:17.0];

    if (reader.friend) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (IBAction)dismissModalView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.moc save:nil];
    }];
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
