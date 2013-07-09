//
//  AppDelegate.m
//  bridge
//
//  Created by JRenero on 05/06/13.
//  Copyright (c) 2013 JRenero. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>

// ----------------------------------------------------------------------
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
// ----------------------------------------------------------------------

@implementation AppDelegate
@synthesize
    myTableView, myIndexTableView, 
    preferencesWindow,
    keylabel, secretlabel;

id py;

NSString *const logFileTableID = @"200";
NSString *const counterTableID = @"201";


// ----------------------------------------------------------------------
// Init work here...
// ----------------------------------------------------------------------
- (AppDelegate *)init {
    if (self = [super init]) {
        loadedRow = -1;
    }
    return self;
}


// ----------------------------------------------------------------------
// Here is where we load the Python Plug-in and connect to it.
// ----------------------------------------------------------------------
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"Application Did Finish Launching");
    
    // Load the plugin: locate it, bundle it, load it.
    NSString *pluginPath = [[NSBundle mainBundle] pathForResource:@"PyFoobar" ofType:@"plugin"];
    NSBundle *pluginBundle = [NSBundle bundleWithPath:pluginPath];
    [pluginBundle load];
    
    // Define the Class-type that will interface with the PYTHON class.
    // "Class" is an opaque type that represents an Objective-C class.
    Class pyClass = [pluginBundle classNamed:@"PyFoobar"];
    
    // Create a generic object of that Class-type.
    py = [[pyClass alloc] init];
    
    //
    // Create a NSMutableArray where adding the data coming from the Python object
    // and add it to the Table. The NSTableView will access the elements in this
    // structure through the methods 'numberOfRowsInTableView' and 'objectValueForTableColumn'.
    //
    myIndexTableData = [[NSMutableArray alloc] init];
    myTableData      = [[NSMutableArray alloc] init];
    
    [myIndexTableData addObject:[(PyFoobar *)py index]];
    [myTableData      addObject:py];
    
    // Redundantly explaining that this line simply reloads the data.
    [myIndexTableView reloadData];
    [myTableView reloadData];
}


// --------------------------------------------------------------------------
// Catching any selection change in Index TableView.
// --------------------------------------------------------------------------
- (IBAction)indexChangeSelected:(id)sender
{
    NSInteger selectedRow = [myIndexTableView selectedRow];
    
    if (selectedRow != -1) {
        myTableData = [[NSMutableArray alloc] init];
        [myTableData addObject:[(PyFoobar *)py getCounters:(int)selectedRow]];
        [myTableView reloadData];
        loadedRow = selectedRow;
    }
}


// --------------------------------------------------------------------------
// This function must be created to know how many rows the table has (array)
// --------------------------------------------------------------------------
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSLog(@"Asking for COUNT on table %@ [%ld]", [tableView identifier], [myIndexTableView selectedRow]);

    BOOL isIndexTable = ( [[tableView identifier] compare:logFileTableID] == NSOrderedSame );
    
    NSUInteger numRows =  [(PyFoobar *)py count:[myIndexTableView selectedRow] withFlag:isIndexTable];
    NSLog(@"Returning %lu rows for table %@", numRows, [tableView identifier]);

    return numRows;
}


// --------------------------------------------------------------------------
// This function must be created to select elements from the table (array)
// --------------------------------------------------------------------------
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)column
            row:(NSInteger)row
{    
    NSTableView *thisTableView = [column tableView];
    BOOL isIndexTable = ( [[tableView identifier] compare:logFileTableID] == NSOrderedSame );

    if (!isIndexTable) {
        NSString *columnIdentifier = [column identifier];
        return [(PyFoobar *)py stringAtColumn:columnIdentifier andRow:(int)row
                              selectedElement:[myIndexTableView selectedRow] withFlag:isIndexTable];
    }
    else {
        return [(PyFoobar *)py stringAtIndex:(int)row];
    }
}


// ----------------------------------------------------------------------
// This is the funcion invoked when Cmd-, is hit.
// ----------------------------------------------------------------------
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
