//
//  GeneralPreferencesViewController.m
//  bridge
//
//  Created by JRenero on 06/06/13.
//  Copyright (c) 2013 JRenero. All rights reserved.
//

#import "GeneralPreferencesViewController.h"
#import "AppDelegate.h"

NSString *const AWS_KEY_FIELD_ID = @"100";
NSString *const AWS_KEY_SECRET_ID = @"101";

@implementation GeneralPreferencesViewController
@synthesize
    applyGeneralPrefsButton,
    GeneralPrefsKeyField,
    GeneralPrefsSecretField,
    key,
    secret;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (IBAction) myMouseAction:(id)sender
{
    NSLog(@"Button pressed");
    NSLog(@"%@, %@", [GeneralPrefsKeyField stringValue], [GeneralPrefsSecretField stringValue]);
    key = [[NSString alloc] initWithString:[GeneralPrefsKeyField stringValue]];
    secret = [[NSString alloc] initWithString:[GeneralPrefsSecretField stringValue]];
    
    [(AppDelegate *)[ [NSApplication sharedApplication] delegate] updateKeyFields:key :secret];
}

- (void)controlTextDidChange:(NSNotification *)notification
{
    NSLog(@"%@", (NSTextField *)[notification.object identifier]);
    //NSTextField *textField = notification.object;
    if ( [[notification.object identifier] caseInsensitiveCompare:AWS_KEY_FIELD_ID] == NSOrderedSame ) {
        //key = [NSString stringWithString:[notification.object stringValue]];
        [(AppDelegate *)[ [NSApplication sharedApplication] delegate ]
            updateKeyString:[notification.object stringValue] ];
    } else {
        //secret = [NSString stringWithString:[notification.object stringValue]];
        [(AppDelegate *)[ [NSApplication sharedApplication] delegate]
            updateSecretString:[notification.object stringValue]];
    }
}

-(NSString *)identifier{
    return @"General";
}

-(NSImage *)toolbarItemImage{
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

-(NSString *)toolbarItemLabel{
    return @"General";
}
                     

@end
