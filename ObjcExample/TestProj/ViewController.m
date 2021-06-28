//
//  ViewController.m
//  TestProj
//
//  Created by Nick Wang on 28/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NestedSpinnerView *spinner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNestedSpinner];
}

- (void)setup {
    _spinner.anchorTextFont = [UIFont boldSystemFontOfSize:18];
    _spinner.anchorTintColor = UIColor.darkTextColor;
    _spinner.popupViewWidth = _spinner.bounds.size.width;
    _spinner.anchorOffset = CGPointMake(0, _spinner.bounds.size.height);
    _spinner.dataSource = @[ [[Entity alloc] init:@""], [[Entity alloc] init:@"Normal Spinner"], [[Entity alloc] init:@"Nested Spinner"] ];
    __weak typeof(self) weakSelf = self;
    _spinner.selectionAction = ^(NSInteger index, NSString * _Nonnull value, id _Nullable userdata) {
        if (value.length == 0) {
            weakSelf.spinner.anchorValue = @"Please Select...";
        }
    };
}

- (void)setupNestedSpinner {
    _spinner.anchorTextFont = [UIFont boldSystemFontOfSize:18];
    _spinner.anchorTintColor = UIColor.darkTextColor;
    NestedSpinnerItem *groupItem1 = [NestedSpinnerItem new];
    groupItem1.groupItemTitle = @"Normal Spinner";
    groupItem1.subItems = @[ [[Entity alloc] init:@"Style 1"], [[Entity alloc] init:@"Style 2"], [[Entity alloc] init:@"Style 3"] ];
    NestedSpinnerItem *groupItem2 = [NestedSpinnerItem new];
    groupItem2.groupItemTitle = @"Nested Spinner";
    groupItem2.subItems = @[ [[Entity alloc] init:@"Style 1"], [[Entity alloc] init:@"Style 2"], [[Entity alloc] init:@"Style 3"] ];
    _spinner.dataTrees = @[ groupItem1, groupItem2 ];
    _spinner.anchorOffset = CGPointMake(0, _spinner.bounds.size.height);
    _spinner.selectionAction = ^(NSInteger index, NSString * _Nonnull value, id _Nullable userdata) {
        NSLog(@"selected value:%@", value);
    };

}

@end
