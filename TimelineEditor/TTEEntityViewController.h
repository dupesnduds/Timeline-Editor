//
//  TTEEntityViewController.h
//  TimelineEditor
//
//  Created by Cleave Pokotea on 23/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entity.h"
#import "ModalViewControllerDelegate.h"

@interface TTEEntityViewController : UITableViewController <ModalViewControllerDelegate>
{
    id<EntityDelegate> delegate;
    
    NSMutableDictionary *entities;
    Entity *editEntity;
    
    BOOL isNewEntity;
}

@property (nonatomic, strong) id<EntityDelegate> delegate;

- (id)initWithEntities:(NSMutableDictionary *)entityList;
- (void)editEntity:(Entity *)entity creation:(BOOL)newEntity;

@end
