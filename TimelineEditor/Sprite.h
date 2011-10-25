//
//  Sprite.h
//  TimelineEditor
//
//  Created by Cleave Pokotea on 21/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

/* 
 Sprites are just UIImageView's because this is just an editor
 not and actual game. Quartz is fine ... i think.
 If cycles are important it's probably best to use a game engine 
 like Cocos2d
 */
@interface Sprite : Entity 
{
	NSString *file; // path the the image that will be used by the UIImageView
	float frameWidth;
	float frameHeight;
    
    BOOL isAnimated;
	int numberOfFrames;
}

@property (readwrite,retain) NSString *file;
@property (readwrite,assign) float frameWidth;
@property (readwrite,assign) float frameHeight;
@property (readwrite,assign) BOOL isAnimated;
@property (readwrite,assign) int numberOfFrames;

@end


@protocol SpriteDelegate <NSObject>

@required
- (void)didAddSprite:(Entity *)sprite;

@end
