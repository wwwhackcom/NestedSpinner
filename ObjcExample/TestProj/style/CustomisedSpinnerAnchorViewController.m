//
//  Customised_spinnerAnchorViewController.m
//  TestProj
//
//  Created by Nick on 22/09/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

#import "CustomisedSpinnerAnchorViewController.h"

@interface CustomisedSpinnerAnchorViewController ()

@property (weak, nonatomic) IBOutlet NestedSpinnerView *spinner;

@end

@implementation CustomisedSpinnerAnchorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Customised Anchor View";
    [self setup];
}

- (void)setup {
    UIColor *color = [UIColor colorWithRed:38.0/255.0 green:156.0/255.0 blue:187.0/255.0 alpha:1];
    _spinner.style.popBackgroundColor = color;
    _spinner.style.tableViewBackgroundColor = color;
    _spinner.style.cellBackgroundColor = color;
    _spinner.style.cellSelectedBackgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:0.3];
    _spinner.style.cellTextColor = [UIColor whiteColor];
    _spinner.style.cellSelectedTextColor = [UIColor whiteColor];
    _spinner.style.cellTextAlignment = NSTextAlignmentLeft;
    _spinner.dataSource = @[ [[Entity alloc] initWithName:@"Accessory Image" withData:@(1)], [[Entity alloc] initWithName:@"No Accessory" withData:@(2)], [[Entity alloc] initWithName:@"Tint Color" withData:@(3)], [[Entity alloc] initWithName:@"Padding" withData:@(4)], [[Entity alloc] initWithName:@"Allignment" withData:@(5)], [[Entity alloc] initWithName:@"Text Font" withData:@(6)], [[Entity alloc] initWithName:@"Popup Offset" withData:@(7)], [[Entity alloc] initWithName:@"Appearance" withData:@(8)] ];
    _spinner.anchorOffset = CGPointMake(0, _spinner.bounds.size.height);
    
    __weak typeof(self) weakSelf = self;
    _spinner.selectionAction = ^(NSIndexPath * _Nonnull indexPath, NSString * _Nonnull value, id _Nullable userdata) {
        if ([userdata isKindOfClass:[Entity class]]) {
            Entity *entity = (Entity *)userdata;
            switch (entity.data.intValue) {
                case 1:
                    if (@available(iOS 13.0, *)) {
                        weakSelf.spinner.anchorImageSize = 28.0;
                        weakSelf.spinner.anchorAccessoryImage = [UIImage systemImageNamed:@"arrow.down.heart.fill"];
                    }
                    break;
                    
                case 2:
                    if (@available(iOS 13.0, *)) {
                        weakSelf.spinner.anchorImageSize = 0;
                    }
                    break;
                    
                case 3:
                    weakSelf.spinner.anchorTintColor = [UIColor colorWithRed:38.0/255.0 green:156.0/255.0 blue:187.0/255.0 alpha:1];
                    break;
                    
                case 4:
                    weakSelf.spinner.anchorPadding = 20.0;
                    break;
                    
                case 5:
                    weakSelf.spinner.anchorTextAlignment = NSTextAlignmentCenter;
                    break;
                    
                case 6:
                    weakSelf.spinner.anchorTextFont = [UIFont italicSystemFontOfSize:20];
                    break;
                    
                case 7:
                    weakSelf.spinner.anchorOffset = CGPointMake(0, weakSelf.spinner.bounds.size.height + 30);
                    break;
                    
                case 8:
                    self.spinner.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
                    self.spinner.layer.cornerRadius = 5.0;
                    self.spinner.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:0.7].CGColor;
                    self.spinner.layer.borderWidth = 2.0;
                    self.spinner.layer.shadowColor = [UIColor blackColor].CGColor;
                    self.spinner.layer.shadowOffset = CGSizeMake(0.0, 5.0);
                    self.spinner.layer.shadowOpacity = 0.6;
                    self.spinner.layer.shadowRadius = 5.0;
                    break;
                    
                default:
                    break;
            }
        }
    };
    [self.view addSubview:_spinner];
}

@end
