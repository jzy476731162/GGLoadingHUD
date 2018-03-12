//
//  GGLoadingView.m
//  animator
//
//  Created by CJ on 2018/3/9.
//  Copyright © 2018年 CJ. All rights reserved.
//

#define shadow1 CGSizeMake(-0.5, -0.5)
#define shadow2 CGSizeMake(0.5, -0.5)
#define shadow3 CGSizeMake(-0.5, 0.5)
#define shadow4 CGSizeMake(0.5, 0.5)


#import "GGLoadingView.h"
@interface GGLoadingView()

@property (nonatomic, strong) CAShapeLayer *layer1;
@property (nonatomic, strong) CAShapeLayer *layer2;
@property (nonatomic, strong) CAShapeLayer *layer3;
@property (nonatomic, strong) CAShapeLayer *layer4;

@property (nonatomic, assign) CGRect frame1;
@property (nonatomic, assign) CGRect frame2;
@property (nonatomic, assign) CGRect frame3;
@property (nonatomic, assign) CGRect frame4;

@end

@implementation GGLoadingView

- (instancetype)init {
    if (self = [super init]) {
        _layer1 = [self createLayer];
        [self.layer addSublayer:_layer1];
        
        _layer2 = [self createLayer];
        [self.layer addSublayer:_layer2];
        
        _layer3 = [self createLayer];
        [self.layer addSublayer:_layer3];
        
        _layer4 = [self createLayer];
        [self.layer addSublayer:_layer4];
        
        [self checkConfigIsValid];
        [self setBackgroundColor:[UIColor lightTextColor]];
    }
    return self;
}

- (void)checkConfigIsValid {
    if (![[GGLoadingViewConfig sharedInstance] pointColors] || ![[[GGLoadingViewConfig sharedInstance] pointColors] count]) {
        [GGLoadingViewConfig sharedInstance].pointColors = @[[UIColor lightGrayColor],[UIColor lightGrayColor],[UIColor lightGrayColor],[UIColor lightGrayColor]];
        
    }else if ([[GGLoadingViewConfig sharedInstance] pointColors].count > 4) {
        [[GGLoadingViewConfig sharedInstance] setPointColors:[[GGLoadingViewConfig sharedInstance].pointColors subarrayWithRange:NSMakeRange(0, 4)]];
        
    }else if ([[GGLoadingViewConfig sharedInstance] pointColors].count < 4){
        NSMutableArray *colorList = [NSMutableArray arrayWithArray:[[GGLoadingViewConfig sharedInstance] pointColors]];
        NSInteger count = [[[GGLoadingViewConfig sharedInstance] pointColors] count];
        NSInteger index = 0;
        while (colorList.count < 4) {
            if (index == count - 1) {
                index = 0;
            }
            [colorList addObject:[[GGLoadingViewConfig sharedInstance] pointColors][index]];
        }
        [[GGLoadingViewConfig sharedInstance] setPointColors:colorList];
    }
    
    if ([[GGLoadingViewConfig sharedInstance] shadowOffset] < 0 && [[GGLoadingViewConfig sharedInstance] shadowOffset] != -1) {
        [[GGLoadingViewConfig sharedInstance] setShadowOffset:fabs([[GGLoadingViewConfig sharedInstance] shadowOffset])] ;
    }
    
    switch ([[GGLoadingViewConfig sharedInstance] animationStyle] ) {
        case GGLoadingViewPresentationStyleCross:
            break;
        case GGLoadingViewPresentationStyleClockwise:
            break;
        case GGLoadingViewPresentationStyleCountclockwise:
            break;
        default:
            break;
    }
    
    
}

- (BOOL)checkShadowIsValid {
    return ([[GGLoadingViewConfig sharedInstance] shadowOffset] != -1);
}

- (CAShapeLayer *)createLayer {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    layer.shadowOpacity = 0.2;
    layer.shadowRadius = 0;
    return layer;
}

+ (void)showInView:(UIView *)view {
    GGLoadingView *loadingView = [[self class] new];
    [loadingView showInView:view];
}

- (void)showInView:(UIView *)view {
    [self resizeSubLayerSize:view];
    [self startAnimation];
}

- (void)resizeSubLayerSize:(UIView *)view {
    CGFloat viewWidth = view.frame.size.width;
    CGFloat viewHeight = view.frame.size.height;
    CGPoint viewCenter = CGPointMake(viewWidth/2, viewHeight/2);
    
    CGFloat boxWidth = 50;
    CGFloat layerWidth = boxWidth * 0.2;
    
    if ([[GGLoadingViewConfig sharedInstance] scaleSize] >= 0.5 && [[GGLoadingViewConfig sharedInstance] scaleSize] <= 2) {
        CGFloat scaleSize = [[GGLoadingViewConfig sharedInstance] scaleSize];
        boxWidth *= scaleSize;
        layerWidth *= scaleSize;
    }
    
    if (!(viewHeight >= boxWidth && viewWidth >= boxWidth)) {
        boxWidth = MAX(viewHeight, viewWidth);
        layerWidth = 0.2 * boxWidth;
    }
    
    self.frame = CGRectMake(viewCenter.x - boxWidth/2, viewCenter.y - boxWidth/2, boxWidth, boxWidth);
    [view addSubview:self];


    CGFloat separator = 3;
    CGFloat standCenter0 = boxWidth/separator;
    CGFloat standCenter1 = boxWidth/separator * (separator - 1);
    
    _frame1 = CGRectMake(standCenter0 - layerWidth/2, standCenter0 - layerWidth/2, layerWidth, layerWidth);
    _frame2 = CGRectMake(standCenter1 - layerWidth/2, standCenter0 - layerWidth/2, layerWidth, layerWidth);
    _frame3 = CGRectMake(standCenter0 - layerWidth/2, standCenter1 - layerWidth/2, layerWidth, layerWidth);
    _frame4 = CGRectMake(standCenter1 - layerWidth/2, standCenter1 - layerWidth/2, layerWidth, layerWidth);
    
    [self.layer1 setPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, layerWidth, layerWidth) cornerRadius:layerWidth/2].CGPath];
    [self.layer1 setFillColor:[UIColor blueColor].CGColor];
    self.layer1.frame = _frame1;
    
    [self.layer2 setPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, layerWidth, layerWidth) cornerRadius:layerWidth/2].CGPath];
    [self.layer2 setFillColor:[UIColor orangeColor].CGColor];
    self.layer2.frame = _frame2;
    
    [self.layer3 setPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, layerWidth, layerWidth) cornerRadius:layerWidth/2].CGPath];
    [self.layer3 setFillColor:[UIColor yellowColor].CGColor];
    self.layer3.frame = _frame3;
    
    [self.layer4 setPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, layerWidth, layerWidth) cornerRadius:layerWidth/2].CGPath];
    [self.layer4 setFillColor:[UIColor greenColor].CGColor];
    self.layer4.frame = _frame4;
}

- (CGPoint)getCenter:(CGRect)rect {
    return CGPointMake((rect.origin.x + rect.size.width/2), (rect.origin.y + rect.size.height/2));
}

- (NSArray *)getTimingFunctions {
    NSArray *frameList = [[GGLoadingViewConfig sharedInstance] animationKeyFrameList];
    if (frameList.count > 0) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:([frameList[0] count])];
        for (NSUInteger i = 0; i < [frameList[0] count]; i++) {
            [arr addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        }
        return arr;
    }
    return nil;
}

//index == 1,2,3,4
- (NSMutableArray *)getPositionValuesWithCenterList:(NSArray *)centerList index:(NSUInteger)index{
    NSMutableArray *positionList = [NSMutableArray new];
    if (index < 1) {
        index = 1;
    }
    NSArray *keyFrameList = [[GGLoadingViewConfig sharedInstance] animationKeyFrameList][index - 1];
    for (NSUInteger i = 0; i <= keyFrameList.count; i++) {
        if (i < keyFrameList.count) {
            [positionList addObject:centerList[[(NSNumber *)keyFrameList[i] integerValue] - 1]];
        }else if (i == keyFrameList.count) {
            [positionList addObject:centerList[[(NSNumber *)keyFrameList[0] integerValue] - 1]];
        }
    }
    return positionList;
}

//index : 1,2,3,4
- (NSMutableArray *)getShadowValuesWithShadowList:(NSArray *)sample index:(NSUInteger)index {
    NSMutableArray *shadowList = [NSMutableArray new];
    if (index < 1) {
        index = 1;
    }
    NSArray *keyFrameList = [[GGLoadingViewConfig sharedInstance] animationKeyFrameList][index - 1];
    for (NSUInteger i = 0; i <= keyFrameList.count; i++) {
        if (i < keyFrameList.count) {
            [shadowList addObject:sample[[(NSNumber *)keyFrameList[i] integerValue] - 1]];
        }else if (i == keyFrameList.count) {
            [shadowList addObject:sample[[(NSNumber *)keyFrameList[0] integerValue] - 1]];
        }
    }
    return shadowList;
}

- (void)startAnimation{

    NSArray *centerList = @[@([self getCenter:_frame1]), @([self getCenter:_frame2]), @([self getCenter:_frame3]), @([self getCenter:_frame4])];
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = 2;
    group.repeatCount = MAXFLOAT;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.values = [self getPositionValuesWithCenterList:centerList index:1];
    animation.timingFunctions = [self getTimingFunctions];
    
    CAAnimationGroup *group1 = [group copy];
    CAKeyframeAnimation *animation1 = [animation copy];
    [animation1 setValues:[self getPositionValuesWithCenterList:centerList index:2]];
    
    CAAnimationGroup *group2 = [group copy];
    CAKeyframeAnimation *animation2 = [animation copy];
    [animation2 setValues:[self getPositionValuesWithCenterList:centerList index:3]];
    
    CAAnimationGroup *group3 = [group copy];
    CAKeyframeAnimation *animation3 = [animation copy];
    [animation3 setValues:[self getPositionValuesWithCenterList:centerList index:4]];
    
    if ([self checkShadowIsValid]) {
        CGFloat shadowOffset = [[GGLoadingViewConfig sharedInstance] shadowOffset];
        
        NSArray *shadowList = @[@(CGSizeMake( -1 * shadowOffset, -1 * shadowOffset)),
                                @(CGSizeMake(      shadowOffset, -1 * shadowOffset)),
                                @(CGSizeMake( -1 * shadowOffset,      shadowOffset)),
                                @(CGSizeMake(      shadowOffset,      shadowOffset))];
        CAKeyframeAnimation * shadowAnimation = [CAKeyframeAnimation animation];
        shadowAnimation.keyPath = @"shadowOffset";

        shadowAnimation.values = [self getShadowValuesWithShadowList:shadowList index:1];
        shadowAnimation.timingFunctions = [self getTimingFunctions];
        
        group.animations = @[animation, shadowAnimation];
        
        CAKeyframeAnimation *shadowAnimation1 = [shadowAnimation copy];
        
        CAKeyframeAnimation *shadowAnimation2 = [shadowAnimation copy];
        
        CAKeyframeAnimation *shadowAnimation3 = [shadowAnimation copy];
        
        
        [shadowAnimation1 setValues:[self getShadowValuesWithShadowList:shadowList index:2]];
        [shadowAnimation2 setValues:[self getShadowValuesWithShadowList:shadowList index:3]];
        [shadowAnimation3 setValues:[self getShadowValuesWithShadowList:shadowList index:4]];
        
        group.animations = @[animation, shadowAnimation];
        group1.animations = @[animation1, shadowAnimation1];
        group2.animations = @[animation2, shadowAnimation2];
        group3.animations = @[animation3, shadowAnimation3];
    }else {
        group.animations = @[animation];
        group1.animations = @[animation1];
        group2.animations = @[animation2];
        group3.animations = @[animation3];
    }
    
    [_layer1 addAnimation:group forKey:@"groupAnimation1"];
    [_layer2 addAnimation:group1 forKey:@"groupAnimation2"];
    [_layer3 addAnimation:group2 forKey:@"groupAnimation3"];
    [_layer4 addAnimation:group3 forKey:@"groupAnimation4"];
    
}

- (void)stopAnimation {
    
}

- (void)dismissCurrently {
    [self stopAnimation];
}

@end

@interface GGLoadingViewConfig()
@property (nonatomic, strong, readwrite) NSArray <NSArray *>*animationKeyFrameList;
@end

@implementation GGLoadingViewConfig
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[GGLoadingViewConfig alloc] init];
        [(GGLoadingViewConfig *)instance setShadowOffset:0.5];
    });
    return instance;
}

- (void)setAnimationStyle:(GGLoadingViewPresentationStyle)animationStyle {
    _animationStyle = animationStyle;
    _animationKeyFrameList = [self getFrameListFromAnimationStyle];
}

- (NSArray<NSArray *> *)animationKeyFrameList {
    if (!_animationKeyFrameList) {
        _animationKeyFrameList = [self getFrameListFromAnimationStyle];
    }
    return _animationKeyFrameList;
}

- (NSArray<NSArray *>*)getFrameListFromAnimationStyle {
    switch (_animationStyle) {
        case GGLoadingViewPresentationStyleCross:
             return @[@[@(1),@(4)],@[@(2),@(3)],@[@(3),@(2)], @[@(4),@(1)]];
            break;
        case GGLoadingViewPresentationStyleClockwise:
            return @[@[@(1),@(2),@(4),@(3)],
                     @[@(2),@(4),@(3),@(1)],
                     @[@(3),@(1),@(2),@(4)],
                     @[@(4),@(3),@(1),@(2)]];
            break;
        case GGLoadingViewPresentationStyleCountclockwise:
            return
                    @[@[@(1),@(3),@(4),@(2)],
                      @[@(2),@(1),@(3),@(4)],
                      @[@(3),@(4),@(2),@(1)],
                      @[@(4),@(2),@(1),@(3)]];
            break;
        default:
            break;
    }
    return nil;
}



@end
