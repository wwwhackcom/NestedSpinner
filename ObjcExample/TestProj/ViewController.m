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
    self.title = @"Examples";
    _spinner.dataSource = @[ [[Entity alloc] init:@"Simple Spinner"], [[Entity alloc] init:@"Nested Spinner"] ];
    _spinner.anchorOffset = CGPointMake(0, _spinner.bounds.size.height);
    _spinner.selectionAction = ^(NSIndexPath * _Nonnull indexPath, NSString * _Nonnull value, id _Nullable userdata) {
        if ([userdata isKindOfClass:[Entity class]]) {
            Entity *entity = (Entity *)userdata;
            if ([entity.name isEqualToString:@"Simple Spinner"]) {
                [self performSegueWithIdentifier:@"identifierSimpleSpinner" sender:nil];
            } else if ([entity.name isEqualToString:@"Nested Spinner"]) {
                [self performSegueWithIdentifier:@"identifierNestedSpinner" sender:nil];
            }
        }
    };
}

@end
