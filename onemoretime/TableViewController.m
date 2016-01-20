//
//  TableViewController.m
//  onemoretime
//
//  Created by Kirill on 29.11.15.
//  Copyright © 2015 Kirill. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController  ()
@property (strong, nonatomic) NSArray *dayNames;
@end
@implementation TableViewController

-(void) viewDidLoad {
    [self namesOfDays];
}

- (void) namesOfDays {
    NSMutableArray *namesOfDays = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        int interval = i*60*60*24;
        NSDate * todayDate = [NSDate dateWithTimeIntervalSinceNow:interval];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        NSString *dayName = [dateFormatter stringFromDate: todayDate];
        [namesOfDays addObject:dayName];
    }
    self.dayNames = namesOfDays;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.dayNames objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.convertedDayTemp objectAtIndex:indexPath.row];
  //  cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", ];
    return cell;
}

@end
