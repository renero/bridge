//
//  AppDelegate.h
//  bridge
//
//  Created by JRenero on 05/06/13.
//  Copyright (c) 2013 JRenero. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "GeneralPreferencesViewController.h"
#import "MASPreferencesWindowController.h"
#import "PyFoobar.h"


@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource>
{
    NSTableView *myTableView;
    NSTableView *myIndexTableView;
    NSMutableArray *myTableData;
    NSMutableArray *myIndexTableData;
    NSWindowController *preferencesWindow;
    
    NSInteger loadedRow;
}

@property (strong) NSWindowController *preferencesWindow;

@property (assign) IBOutlet NSWindow *window;

@property (retain) IBOutlet NSTableView *myTableView;
@property (retain) IBOutlet NSTableView *myIndexTableView;

@property (retain) IBOutlet NSTextField *keylabel;
@property (retain) IBOutlet NSTextField *secretlabel;


- (IBAction)indexChangeSelected:(id)sender;
- (IBAction)displayPreferences:(id)sender;
- (void) updateKeyString:(NSString *)string;
- (void) updateSecretString:(NSString *)string;
- (void) updateKeyFields:(NSString *)string1 :(NSString *)string2;

@end
