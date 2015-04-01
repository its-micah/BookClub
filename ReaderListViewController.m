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
@property NSArray *readersArray;
@property (strong, nonatomic) IBOutlet UITableView *readersTableView;

@end

@implementation ReaderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [Reader retrieveReaders       WithCompletion:^(NSArray *readers) {
//        self.readersArray = readers;
//    }];
//
    [Reader retrieveReaders:self.moc WithCompletion:^(NSArray *readers) {
        self.readersArray = readers;
        [self.readersTableView reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.readersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Reader *reader = self.readersArray[indexPath.row];
    cell.textLabel.text = reader.name;
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
