//
//  NestedSpinnerViewController.m
//  TestProj
//
//  Created by Nick on 22/09/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

#import "NestedSpinnerViewController.h"

@interface NestedSpinnerViewController ()

@property (strong, nonatomic) NestedSpinnerView *spinner;

@end

@implementation NestedSpinnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Nested Spinner";
    [self setup];
}

- (void)setup {
    [NestedSpinnerAppearance darkNested];
    _spinner = [[NestedSpinnerView alloc] initWithFrame:CGRectMake(50, 160, self.view.bounds.size.width - 100, 50)];
    _spinner.style.cellSelectedBackgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
    _spinner.anchorTextFont = [UIFont boldSystemFontOfSize:18];
    _spinner.anchorTintColor = UIColor.darkTextColor;
    _spinner.cellNib = [UINib nibWithNibName:NSStringFromClass([NestedSubItemCell class]) bundle:NestedSpinnerBundle.bundle];
    NestedSpinnerItem *groupItem1 = [NestedSpinnerItem new];
    groupItem1.groupItemTitle = @"Basic Usage";
    groupItem1.subItems = @[ [[Entity alloc] initWithName:@"Normal Spinner" withData:@(1)], [[Entity alloc] initWithName:@"Nested Spinner" withData:@(2)], [[Entity alloc] initWithName:@"Programmatically" withData:@(3)] ];
    NestedSpinnerItem *groupItem2 = [NestedSpinnerItem new];
    groupItem2.groupItemTitle = @"Customised";
    groupItem2.subItems = @[ [[Entity alloc] initWithName:@"Custom Attributes" withData:@(4)], [[Entity alloc] initWithName:@"Delegate Colours" withData:@(5)], [[Entity alloc] initWithName:@"Custom AnchorView" withData:@(6)] ];
    _spinner.dataTrees = @[ groupItem1, groupItem2 ];
    _spinner.anchorOffset = CGPointMake(0, _spinner.bounds.size.height);
    _spinner.selectionAction = ^(NSIndexPath * _Nonnull indexPath, NSString * _Nonnull value, id _Nullable userdata) {
        NSLog(@"indexPath: %@, selected value:%@", indexPath, value);
        if ([userdata isKindOfClass:[Entity class]]) {
            Entity *entity = (Entity *)userdata;
            
            switch (entity.data.intValue) {
                case 1:
                    break;
                
                default:
                    break;
            }
            
        }
    };
    [self.view addSubview:_spinner];
}

@end
