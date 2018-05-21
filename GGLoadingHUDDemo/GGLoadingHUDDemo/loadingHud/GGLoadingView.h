//
//  GGLoadingView.h
//  animator
//
//  Created by CJ on 2018/3/9.
//  Copyright © 2018年 CJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GGLoadingViewPresentationStyle) {
    GGLoadingViewPresentationStyleCross,
    GGLoadingViewPresentationStyleClockwise,
    GGLoadingViewPresentationStyleCountclockwise,
};

@interface GGLoadingViewAnimationDelegagte

- (void)animateFinished;

@end

@interface GGLoadingView : UIView

+ (instancetype)showInView:(__weak UIView *)view;


- (BOOL)isAnimating;
- (void)stopAnimation;

@end

@interface GGLoadingViewConfig : NSObject
+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSArray <UIColor *>*pointColors;//best for four 
@property (nonatomic, assign) CGFloat shadowOffset; //default 0.5 disable = -1
@property (nonatomic, assign) CGFloat scaleSize;//default is 1 [0.5...2]
@property (nonatomic, strong) UIColor *shadowColor;//default black
@property (nonatomic, assign) GGLoadingViewPresentationStyle animationStyle;

@property (nonatomic, strong, readonly) NSArray <NSArray *>*animationKeyFrameList;

@end
