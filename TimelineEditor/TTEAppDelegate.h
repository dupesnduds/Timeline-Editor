//
//  TTEAppDelegate.h
//  TimelineEditor
//
//  Created by Cleave Pokotea on 21/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTEStage;

@interface TTEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TTEStage *viewController;

@end
