//
//  CustomisedSimpleSpinnerViewController.m
//  TestProj
//
//  Created by Nick on 22/09/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

#import "CustomisedSimpleSpinnerViewController.h"

@interface CustomisedSimpleSpinnerViewController ()

@end

@implementation CustomisedSimpleSpinnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Customised Simple Spinner";
    [self setup1];
    [self setup2];
}

- (void)setup1 {
    UIColor *color = [UIColor colorWithRed:38.0/255.0 green:156.0/255.0 blue:187.0/255.0 alpha:1];
    NestedSpinnerView *spinner = [[NestedSpinnerView alloc] initWithFrame:CGRectMake(50, 120, self.view.bounds.size.width - 100, 50)];
    spinner.anchorTintColor = color;
    spinner.style.popBackgroundColor = color;
    spinner.style.tableViewBackgroundColor = color;
    spinner.style.cellBackgroundColor = color;
    spinner.style.cellSelectedBackgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:0.3];
    spinner.style.cellTextColor = [UIColor whiteColor];
    spinner.style.cellSelectedTextColor = [UIColor whiteColor];
    spinner.style.cellTextAlignment = NSTextAlignmentLeft;
    spinner.anchorTextFont = [UIFont boldSystemFontOfSize:18];
    spinner.anchorValue = @"Select Language";
    spinner.dataSource = @[ [[Entity alloc] init:@""], [[Entity alloc] initWithName:@"简体中文" withImage:[UIImage imageNamed:@"chinese"]], [[Entity alloc] initWithName:@"English" withImage:[UIImage imageNamed:@"english"]], [[Entity alloc] initWithName:@"Español" withImage:[UIImage imageNamed:@"spanish"]], [[Entity alloc] initWithName:@"Português" withImage:[UIImage imageNamed:@"portuguese"]], [[Entity alloc] initWithName:@"Français" withImage:[UIImage imageNamed:@"french"]] ];
    spinner.anchorOffset = CGPointMake(0, spinner.bounds.size.height);
    
    __weak typeof(spinner) weakSelf = spinner;
    spinner.selectionAction = ^(NSIndexPath * _Nonnull indexPath, NSString * _Nonnull value, id _Nullable userdata) {
        if ([userdata isKindOfClass:[Entity class]]) {
            Entity *entity = (Entity *)userdata;
            if (entity.name.length == 0) {
                weakSelf.anchorValue = @"Select Language";
            }
        }
    };
    [self.view addSubview:spinner];
}

- (void)setup2 {
    UIColor *color = [UIColor colorWithRed:92.0/255.0 green:171.0/255.0 blue:0.0 alpha:1];
    NestedSpinnerView *spinner = [[NestedSpinnerView alloc] initWithFrame:CGRectMake(50, 240, self.view.bounds.size.width - 100, 50)];
    spinner.style.popBackgroundColor = color;
    spinner.anchorTintColor = color;
    spinner.style.tableViewBackgroundColor = color;
    spinner.style.cellBackgroundColor = color;
    spinner.style.cellSelectedBackgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:0.2];
    spinner.style.cellTextColor = [UIColor whiteColor];
    spinner.style.cellSelectedTextColor = [UIColor whiteColor];
    spinner.anchorTextFont = [UIFont boldSystemFontOfSize:16];
    spinner.anchorValue = @"Select Language";
    spinner.dataSource = @[ [[Entity alloc] init:@"Swift"], [[Entity alloc] init:@"Objc"], [[Entity alloc] init:@"Kotlin"], [[Entity alloc] init:@"Java"], [[Entity alloc] init:@"TypeScript"], [[Entity alloc] init:@"Go"], [[Entity alloc] init:@"C#"], [[Entity alloc] init:@"Python"], [[Entity alloc] init:@"PHP"] ];
    spinner.anchorOffset = CGPointMake(0, spinner.bounds.size.height);
    [self.view addSubview:spinner];
}

@end
