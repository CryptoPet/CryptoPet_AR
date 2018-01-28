//
//  InfoViewController.m
//  TestARKit2
//
//  Created by Junchao Yu on 2018/1/27.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "InfoViewController.h"

@interface InfoViewController ()

@property (nonatomic, strong) UIImageView * imagev;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UIImage * image = [UIImage imageNamed:@"page-1-iphone-7-copy-2"];
    self.imagev = [[UIImageView alloc] initWithImage:image];
    self.imagev.frame = self.view.bounds;
    [self.view addSubview:self.imagev];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 80);
    [button addTarget:self action:@selector(btClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self animation2];
    [self animation2];
    [self animation2];
    [self playSound];
}

- (void)btClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playSound {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"1426.wav" withExtension:nil];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    AudioServicesPlaySystemSound(soundID);
}

//烟花动画
- (void)animation2 {
    // Cells spawn in the bottom, moving up
    
    //分为3种粒子，子弹粒子，爆炸粒子，散开粒子
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    fireworksEmitter.emitterSize    = CGSizeMake(viewBounds.size.width/2.0, 0.0);
    fireworksEmitter.emitterMode    = kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape   = kCAEmitterLayerLine;
    fireworksEmitter.renderMode     = kCAEmitterLayerAdditive;
    fireworksEmitter.seed = (arc4random()%100)+1;
    
    // Create the rocket
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    rocket.birthRate        = 1.0;
    rocket.emissionRange    = 0.25 * M_PI;  // some variation in angle
    rocket.velocity         = 380;
    rocket.velocityRange    = 100;
    rocket.yAcceleration    = 75;
    rocket.lifetime         = 1.02; // we cannot set the birthrate < 1.0 for the burst
    
    //小圆球图片
    rocket.contents         = (id) [[UIImage imageNamed:@"DazRings"] CGImage];
    rocket.scale            = 0.2;
    rocket.color            = [[UIColor redColor] CGColor];
    rocket.greenRange       = 1.0;      // different colors
    rocket.redRange         = 1.0;
    rocket.blueRange        = 1.0;
    rocket.spinRange        = M_PI;     // slow spin
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate         = 1.0;      // at the end of travel
    burst.velocity          = 0;        //速度为0
    burst.scale             = 2.5;      //大小
    burst.redSpeed          =-1.5;      // shifting
    burst.blueSpeed         =+1.5;      // shifting
    burst.greenSpeed        =+1.0;      // shifting
    burst.lifetime          = 0.35;     //存在时间
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate         = 400;
    spark.velocity          = 125;
    spark.emissionRange     = 2* M_PI;  // 360 度
    spark.yAcceleration     = 75;       // gravity
    spark.lifetime          = 3;
    //星星图片
    spark.contents          = (id) [[UIImage imageNamed:@"DazStarOutline"] CGImage];
    spark.scaleSpeed        =-0.2;
    spark.greenSpeed        =-0.1;
    spark.redSpeed          = 0.4;
    spark.blueSpeed         =-0.1;
    spark.alphaSpeed        =-0.25;
    spark.spin              = 2* M_PI;
    spark.spinRange         = 2* M_PI;
    
    // 3种粒子组合，可以根据顺序，依次烟花弹－烟花弹粒子爆炸－爆炸散开粒子
    fireworksEmitter.emitterCells   = [NSArray arrayWithObject:rocket];
    rocket.emitterCells             = [NSArray arrayWithObject:burst];
    burst.emitterCells              = [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:fireworksEmitter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
