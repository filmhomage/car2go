//
//  FMViewController+TableView.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/27.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMViewController+TableView.h"

@implementation FMViewController (TableView)

-(void)initializeTableView {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)updateTableView:(NSArray*)array {
    [self.tableView reloadData];
    [self stoppedScrolling:NO];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayVehicles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FMTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FMTableViewCell"];
    if(!cell){
        cell = [[FMTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FMTableViewCell"];
    }
    [cell configureCell:self.arrayVehicles[indexPath.row] withIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.arrayVehicles.count > indexPath.row) {
        [self updatePinToCenter:indexPath.row withDrawRoute:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSIndexPath* indexPath = self.tableView.indexPathsForVisibleRows.firstObject;
    if(self.arrayVehicles.count > indexPath.row) {
        [self updatePinToCenter:indexPath.row withDrawRoute:NO];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self stoppedScrolling:NO];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
        [self stoppedScrolling:NO];
    }
}

-(void)stoppedScrolling:(BOOL)withSelect {
    
    NSIndexPath* indexPath = self.tableView.indexPathsForVisibleRows.firstObject;
    if(self.arrayVehicles.count > indexPath.row) {
        if(withSelect) {
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
        [self updatePinToCenter:indexPath.row withDrawRoute:withSelect];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsZero];
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
        [cell setPreservesSuperviewLayoutMargins:NO];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsZero];
}

@end
