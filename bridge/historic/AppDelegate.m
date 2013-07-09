//
//  AppDelegate.m
//  bridge
//
//  Created by JRenero on 05/06/13.
//  Copyright (c) 2013 JRenero. All rights reserved.
//

#import "AppDelegate.h"

#import <objc/runtime.h>

@implementation AppDelegate
@synthesize
    tableView,
    preferencesWindow,
    keylabel, secretlabel;

id py;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //
    // To install py2app:
    //
    //   $ curl -O http://peak.telecommunity.com/dist/ez_setup.py
    //   $ sudo python ez_setup.py -U setuptools
    //   $ sudo easy_install -U py2app
    //
    // Connect to the plugin created with
    //
    //   $ python setup.py py2app -A
    //
    // setup.py should look like this:
    //
    //    from distutils.core import setup
    //    import py2app
    //
    //    setup(
    //          plugin = ['PyFoobar.py']
    //    )
    //
    // Then take the plugin in 'dist' folder and add it to the project.
    //
    NSString *pluginPath = [[NSBundle mainBundle] pathForResource:@"PyFoobar"
                                                           ofType:@"plugin"];
    NSBundle *pluginBundle = [NSBundle bundleWithPath:pluginPath];
    [pluginBundle load];
    Class pyClass = [pluginBundle classNamed:@"PyFoobar"];
    py = [[pyClass alloc] init];
    
    tableData = [[NSMutableArray alloc] init];
    [tableData addObject:py];
    [tableView reloadData];
}


- (IBAction)displayPreferences:(id)sender
{
    if(preferencesWindow == nil)
    {
        NSViewController *generalViewController = [[GeneralPreferencesViewController alloc]
                                                   initWithNibName:@"GeneralPreferencesViewController"
                                                   bundle:[NSBundle mainBundle]];
        NSArray *views = [NSArray arrayWithObjects:generalViewController, nil];
        NSString *title = NSLocalizedString(@"Preferences", @"Common title for Preferences window");
        preferencesWindow = [[MASPreferencesWindowController alloc] initWithViewControllers:views title:title];
    }
    [preferencesWindow showWindow:self];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [(PyFoobar *)py count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)column
            row:(NSInteger)row
{
    NSString *columnIdentifier = [column identifier];
    return [(PyFoobar *)py stringAtColumn:columnIdentifier andRow:row];
    //return [(PyFoobar *)py stringAtIndex:row];
}

- (void) updateKeyString:(NSString *)string
{
    if (string != nil)
        [keylabel setStringValue: string];
}

- (void) updateSecretString:(NSString *)string
{
    if (string != nil)
        [secretlabel setStringValue: string];
}


- (void) updateKeyFields:(NSString *)string1 :(NSString *)string2
{
    if (string1 != nil)
        [keylabel setStringValue: string1];
    if (string2 != nil)
        [secretlabel setStringValue: string2];
}

@end
