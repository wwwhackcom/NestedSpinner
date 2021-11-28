//
//  SimpleSpinnerViewController.m
//  TestProj
//
//  Created by Nick on 22/09/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

#import "SimpleSpinnerViewController.h"

@interface SimpleSpinnerViewController ()

@property (strong, nonatomic) NestedSpinnerView *spinner;

@end

@implementation SimpleSpinnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Simple Spinner";
    [self setup:@"Dark Style"];
}

- (void)setup:(NSString *)style {
    [self setStyle:style];
    _spinner = [[NestedSpinnerView alloc] initWithFrame:CGRectMake(50, 160, self.view.bounds.size.width - 100, 50)];
    _spinner.anchorTextFont = [UIFont boldSystemFontOfSize:18];
    _spinner.anchorTintColor = UIColor.darkTextColor;
    _spinner.dataSource = @[ [[Entity alloc] init:@"Light Style"], [[Entity alloc] init:@"Dark Style"], [[Entity alloc] init:@"Customised Globally"], [[Entity alloc] initWithName:@"Customised Attributes" withData: @(1)], [[Entity alloc] initWithName:@"Customised AnchorView" withData: @(2)] ];
    _spinner.anchorOffset = CGPointMake(0, _spinner.bounds.size.height);
    
    __weak typeof(self) weakSelf = self;
    _spinner.selectionAction = ^(NSIndexPath * _Nonnull indexPath, NSString * _Nonnull value, id _Nullable userdata) {
        if ([userdata isKindOfClass:[Entity class]]) {
            Entity *entity = (Entity *)userdata;
            if (entity.data == nil) {
                [weakSelf.spinner removeFromSuperview];
                [weakSelf setup:entity.name];
                weakSelf.spinner.anchorValue = entity.name;
            } else {
                switch (entity.data.intValue) {
                    case 1:
                        [weakSelf performSegueWithIdentifier:@"identifierCustomisedSimpleSpinner" sender:nil];
                        break;
                    case 2:
                        [weakSelf performSegueWithIdentifier:@"identifierCustomisedAnchorSpinner" sender:nil];
                        break;
                    default:
                        break;
                }
            }
        }
    };
    [self.view addSubview:_spinner];
}

- (void)setStyle:(NSString *)style {
    if ([style isEqualToString:@"Light Style"]) {
        [NestedSpinnerAppearance light];
    } else if ([style isEqualToString:@"Dark Style"]) {
        [NestedSpinnerAppearance dark];
    } else if ([style isEqualToString:@"Customised Globally"]) {
        [NestedSpinnerAppearance customisedStyle];
    }
}

@end
