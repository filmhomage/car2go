//
//  FMViewController+TableView.h
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMViewController.h"

@interface FMViewController (TableView) <UITableViewDelegate, UITableViewDataSource>

-(void)initializeTableView;
-(void)updateTableView:(NSArray*)array;

@end
