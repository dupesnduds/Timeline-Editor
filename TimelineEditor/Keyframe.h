//
//  Keyframe.h
//  TimelineEditor
//
//  Created by Cleave Pokotea on 21/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Keyframe : NSObject
{
    CGPoint position;

	int frame;
	float rotation;
	int opacity;
	float scale;
	
	BOOL animate;
	int fromFrame;
	int toFrame;
}

@property (readwrite,assign) CGPoint position;
@property (readwrite,assign) float time;
@property (readwrite,assign) int frame;
@property (readwrite,assign) float rotation;
@property (readwrite,assign) int opacity;
@property (readwrite,assign) float scale;
@property (readwrite,assign) BOOL animate;
@property (readwrite,assign) int fromFrame;
@property (readwrite,assign) int toFrame;

- (void)setDefaults;

@end
