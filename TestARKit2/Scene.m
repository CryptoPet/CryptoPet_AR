//
//  Scene.m
//  TestARKit2
//
//  Created by Junchao Yu on 2018/1/27.
//  Copyright © 2018年 silver6wings. All rights reserved.
//

#import "Scene.h"

@implementation Scene

int showNumber = 0;
BOOL didShow = false;
CFTimeInterval creationTime = -1;

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
//    [self addNewAnchorWithFrame:currentFrame View:sceneView X:0 Y:0 Z:-0.3];
}

- (void)update:(CFTimeInterval)currentTime {
    if (currentTime > creationTime) {
        ARSKView *sceneView = (ARSKView *)self.view;
        ARFrame *currentFrame = [sceneView.session currentFrame];
        
        showNumber++;
        
        if (showNumber == 2) {
            for (int i = 0; i < 120; i++) {
                float s = 1.5f;
                float x = arc4random() % 100 / 100.0f - 0.5;
                float y = arc4random() % 100 / 100.0f - 0.5;
                float z = arc4random() % 100 / 100.0f - 0.5;
                [self addNewAnchorWithFrame:currentFrame View:sceneView X:x*s Y:y*s Z:z*s];
            }
        }
        creationTime = currentTime + 1;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self.view isKindOfClass:[ARSKView class]]) {
        return;
    }
}

- (void)addNewAnchorWithFrame:(ARFrame *)currentFrame
                         View:(ARSKView *)sceneView
                            X:(float)x
                            Y:(float)y
                            Z:(float)z {
    if (currentFrame) {
        matrix_float4x4 translation = matrix_identity_float4x4;
        translation.columns[3].x = x;
        translation.columns[3].y = y;
        translation.columns[3].z = z;
        matrix_float4x4 transform = matrix_multiply(currentFrame.camera.transform, translation);
        
        ARAnchor *anchor = [[ARAnchor alloc] initWithTransform:transform];
        [sceneView.session addAnchor:anchor];
    }
    
    
}

@end
