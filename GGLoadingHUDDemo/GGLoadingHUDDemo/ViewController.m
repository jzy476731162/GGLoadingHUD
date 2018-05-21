//
//  ViewController.m
//  GGLoadingHUDDemo
//
//  Created by Carl Ji on 2018/5/18.
//  Copyright © 2018年 Carl Ji. All rights reserved.
//

#import "ViewController.h"

#import "GGLoadingView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *testTableView;
@property (nonatomic, weak) GGLoadingView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation ViewController
- (IBAction)triggerAction:(id)sender {
    if (self.loadingView.isAnimating) {
        [self.loadingView stopAnimation];
    }else {
        self.loadingView = [GGLoadingView showInView:self.view];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[GGLoadingViewConfig sharedInstance] setAnimationStyle:GGLoadingViewPresentationStyleCross];
    
//    [[GGLoadingViewConfig sharedInstance] setAnimationStyle:GGLoadingViewPresentationStyleClockwise];
//    [[GGLoadingViewConfig sharedInstance] setAnimationStyle:GGLoadingViewPresentationStyleCountclockwise];
    __weak typeof(self)weakSelf = self;
    self.loadingView = [GGLoadingView showInView:weakSelf.view];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
