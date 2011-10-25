//
//  TTEFileBrowser.h
//  TimelineEditor
//
//  Created by Cleave Pokotea on 23/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTEFileBrowserDelegate <NSObject>

@required
- (void)didSelectFile:(NSString *)file;

@end

@interface TTEFileBrowser : UITableViewController
{
    id<TTEFileBrowserDelegate> delegate;
    NSArray *fileExtensions;
    NSMutableArray *directoryContent;
    
    
}

@property (readwrite, retain) id<TTEFileBrowserDelegate> delegate;

- (id)initWithExtensions:(NSArray *)extensions;
- (void)listFiles;

@end


