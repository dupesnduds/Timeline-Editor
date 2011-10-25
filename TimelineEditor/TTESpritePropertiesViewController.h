//
//  TTESpritePropertiesViewController.h
//  TimelineEditor
//
//  Created by Cleave Pokotea on 23/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sprite.h"
#import "TTEFileBrowser.h"
#import "ModalViewControllerDelegate.h"




@interface TTESpritePropertiesViewController : UIViewController <TTEFileBrowserDelegate>
{
    id<ModalViewControllerDelegate> modalDelegate;
    
    Sprite *sprite;
    UIPopoverController *fileBrowserPopover;
    
    // Entity (Sprite root)
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *posXTextField;
	IBOutlet UITextField *posYTextField;
    IBOutlet UITextField *zIndexTextField;
    
    // Sprite
	IBOutlet UITextField *fileNameTextField;
	IBOutlet UITextField *frameWidthTextField;
	IBOutlet UITextField *frameHeightTextField;
}

//@property (readonly) Sprite *sprite;
@property (nonatomic, retain) id<ModalViewControllerDelegate> modalDelegate;

- (id)initWithSprite:(Sprite *)initSprite;
- (IBAction)dismissViewWithDone:(id)sender;
- (IBAction)browseFiles:(id)sender;
- (void)addSprite:(Entity *)entity;

@end
