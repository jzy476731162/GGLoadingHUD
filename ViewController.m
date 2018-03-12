//
//  ViewController.m
//  animator
//
//  Created by CJ on 2018/3/9.
//  Copyright © 2018年 CJ. All rights reserved.
//

#import "ViewController.h"

#import "GGLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)triggerAction:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[GGLoadingViewConfig sharedInstance] setAnimationStyle:GGLoadingViewPresentationStyleCountclockwise];
    [GGLoadingView showInView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
