//
//  PyFoobar.h
//  bridge
//
//  Created by JRenero on 05/06/13.
//  Copyright (c) 2013 JRenero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PyFoobar : NSObject {}

- (id)index;
- (id)printKeys;
- (void)dump;
- (id)getCounters:(int)row;

- (int)count:(NSInteger)selectedElement withFlag:(BOOL)isIndexTable;

- (NSString *)stringAtColumn:(NSString *)column andRow:(int)row
             selectedElement:(NSInteger)selectedElement withFlag:(BOOL)isIndexTable;

- (NSString *)stringAtIndex:(int)aIndex;

@end
