//
//  ModalViewControllerDelegate.h
//  TimelineEditor
//
//  Created by Cleave Pokotea on 23/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModalViewControllerDelegate <NSObject>

@required
- (void)didDismissModalViewWithDone;

@optional
- (void)didDismissModalViewWithCancel;

@end
