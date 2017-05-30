//
//  FMViewController.m
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/05/29.
//  Copyright © 2017 kokaru. All rights reserved.
//

#import "FMViewController.h"

#define METERS_PER_MILE 1609.344

@implementation FMViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[FMLocationManager sharedInstance]requestWhenInUseAuthorization];
    [self initializeLocation];
    [self initializeMap];
    [self initializeTableView];
    [self addRefresshControl];
    [self addNavigationLeft];
    
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = FMThemeColor;
    self.memoryFirst = [[FMMemoryUsage sharedInstance] printMemoryUsage];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateMemoryLabel:) userInfo:nil repeats:YES];
}

-(void)updateMemoryLabel:(NSTimer*)timer {
    
    UIBarButtonItem* item = (UIBarButtonItem*)self.navigationItem.rightBarButtonItem;
    UILabel* labelMemoryUsage;
    if([item.customView isKindOfClass:[UILabel class]]) {
        labelMemoryUsage = (UILabel*)item.customView;
        
        NSString* current = [[FMMemoryUsage sharedInstance] printMemoryUsage];
        labelMemoryUsage.text = [NSString stringWithFormat:@"MEMORY USAGE : %ld MB", (long)(current.integerValue - self.memoryFirst.integerValue)];
    }
}

-(void)addRefresshControl {

    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = FMThemeColor;
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(getLatestVehicles) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

-(void)addNavigationLeft {
    
    UIImage* buttonImage = [UIImage imageNamed: @"hamburger_menu_blue"];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width/2, 32);
    [button addTarget:self action:@selector(navigationLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* labelRight = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400, 32)];
    labelRight.textAlignment = NSTextAlignmentRight;
    labelRight.textColor = FMThemeColor;
    labelRight.font = [UIFont boldSystemFontOfSize:12];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:labelRight];
}

-(void)navigationLeftButton:(UIButton*)button {
    
    button.selected = !button.selected;
    
    [self.view layoutIfNeeded];
    
    if(button.selected) {
        self.viewLeftContainer.hidden = NO;
        self.viewLeftContainer.alpha = 0.3f;
        [UIView animateWithDuration:0.4f animations:^{
            self.constraintLeftWidth.constant = 316.0f;
            self.viewLeftContainer.alpha = 1.0f;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    } else {
        [UIView animateWithDuration:0.4f animations:^{
            self.constraintLeftWidth.constant = 0.0f;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.viewLeftContainer.hidden = YES;
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self vehiclesAPI];
}

-(void)getLatestVehicles {
    
    [self.refreshControl beginRefreshing];
    [self vehiclesAPI];
}

-(void)vehiclesAPI {
    
    [self vehiclesAPI:^(NSArray *arrayList) {
        self.arrayVehicles = arrayList;
        [self addAnnotation:self.arrayVehicles];
        [self reloadData];
    }];
}

-(void)reloadData {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshControl) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM d, h:mm:ss a"];
            NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
            self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
            [self performSelector:@selector(endRefresh) withObject:nil afterDelay:1.0f];
        }
    });
}

-(void)endRefresh {
    [self.refreshControl endRefreshing];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

-(IBAction)currentLocatioinButtonTapped:(UIButton *)sender {
    [self updateCurrentLocationWithoutZoom];
}

-(IBAction)segmentedValueChanged:(UISegmentedControl *)sender {
}

@end
