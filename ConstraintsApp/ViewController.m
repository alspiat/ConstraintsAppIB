//
//  ViewController.m
//  ConstraintsApp
//
//  Created by Алексей on 27.06.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    BOOL isRedViewSmall;
    BOOL isBlueViewSmall;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isRedViewSmall = NO;
    isBlueViewSmall = NO;
}

- (IBAction)redViewButtonTapped:(UIButton *)sender {
    
    CGFloat metrics;
    CGFloat constant;
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        metrics = self.view.bounds.size.height;
    } else {
        metrics = self.view.bounds.size.width;
    }
    
    if (isRedViewSmall) {
        constant = 0;
        isRedViewSmall = NO;
    } else if (!isRedViewSmall && isBlueViewSmall) {
        constant = -metrics / 3;
        isRedViewSmall = YES;
        isBlueViewSmall = NO;
    } else {
        constant = -metrics / 3;
        isRedViewSmall = YES;
    }
    
    self.heightConstraint.constant = constant;
    self.widthConstraint.constant = constant;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
}

- (IBAction)blueViewButtonTapped:(UIButton *)sender {
    
    CGFloat metrics;
    CGFloat constant;
    
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        metrics = self.view.bounds.size.height;
    } else {
        metrics = self.view.bounds.size.width;
    }
    
    if (isBlueViewSmall) {
        constant = 0;
        isBlueViewSmall = NO;
    } else if (!isBlueViewSmall && isRedViewSmall) {
        constant = metrics / 3;
        isBlueViewSmall = YES;
        isRedViewSmall = NO;
    } else {
        constant = metrics / 3;
        isBlueViewSmall = YES;
    }
    
    self.heightConstraint.constant = constant;
    self.widthConstraint.constant = constant;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        CGFloat constant = 0;

        if (isRedViewSmall) {
            constant -=  self.view.bounds.size.width / 3;
        } else if (isBlueViewSmall) {
            constant +=  self.view.bounds.size.width / 3;
        }

        self.heightConstraint.constant = constant;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
