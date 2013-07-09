//
//  GeneralPreferencesViewController.h
//  bridge
//
//  Created by JRenero on 06/06/13.
//  Copyright (c) 2013 JRenero. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"

@interface GeneralPreferencesViewController : NSViewController <MASPreferencesViewController>
{
    NSString *key;
    NSString *secret;

}
@property (retain) IBOutlet NSButton *applyGeneralPrefsButton;
@property (retain) IBOutlet NSTextField *GeneralPrefsKeyField;
@property (retain) IBOutlet NSTextField *GeneralPrefsSecretField;

@property (atomic, retain) NSString *key;
@property (atomic, retain) NSString *secret;

- (IBAction) myMouseAction:(id)sender;
- (void)controlTextDidChange:(NSNotification *)notification;
- (BOOL)commitEditing;


@end
